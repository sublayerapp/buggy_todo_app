require "pry"

class BugMonitorAgent < Sublayer::Agents::Base
  REPO_PATH = File.expand_path("../..", __FILE__)
  GITHUB_REPO = "sublayerapp/buggy_todo_app" # Replace with your fork or repo
  MODELS = ["gpt-4o", "claude-3-5-sonnet-latest", "gemini/gemini-2.0-flash"]

  trigger(
    AsanaAssignedToAgentTrigger.new(project_id: ENV["TASK_DEMO_ASANA_PROJECT_ID"]) do |event|
      @current_event = event
      take_step
    end
  )

  step do
    asana_task = AsanaGetTaskAction.new(task_gid: @current_event.resource.gid).call

    MODELS.each do |model|
      Dir.chdir(REPO_PATH) do
        BRANCH_NAME = "fix-#{asana_task.gid}-#{model}-#{Time.now.to_i}"
        system("git", "checkout", "main")
        system("git", "pull", "origin", "main")
        system("git", "checkout", "-b", BRANCH_NAME)
        puts "Checked out #{BRANCH_NAME}"

        puts "Calling Aider"
        aider_output = RunAiderCommandAction.new(
          message: generate_aider_message(task_name: asana_task.name, task_description: asana_task.notes),
          model: model
        ).call

        puts "Aider output: #{aider_output[0]}"

        system("git", "push", "-u", "origin", BRANCH_NAME)

        new_pr = GithubCreatePRAction.new(
          repo: GITHUB_REPO,
          base: "main",
          head: BRANCH_NAME,
          title: "Fix: #{asana_task.name}",
          body: "Fixed by Aider model: #{model}"
        ).call

        GithubCreateCommentAction.new(
          repo: GITHUB_REPO,
          pr_number: new_pr.number,
          body: "```shell\n#{aider_output[0]}\n```"
        ).call
      end
    end
  end

  def generate_aider_message(task_name:, task_description:)
    <<-MSG
    We received a bug report titled: #{task_name} with a description of: #{task_description}

    First write a test covering this bug and then fix this bug and only this bug
    If you need to add any fields to the database, create a new migration rather than editing existing ones
    MSG
  end

  goal_condition { false }
  check_status { true }
end
