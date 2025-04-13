require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "clicking a task redirects to the task's show page" do
    visit tasks_path
    first_task = Task.first
    click_link first_task.title
    assert_current_path task_path(first_task)
    assert_text first_task.title
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "should create task" do
    visit tasks_url
    click_on "New task"

    check "Completed" if @task.completed
    fill_in "Title", with: @task.title
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "should update Task" do
    visit task_url(@task)
    click_on "Edit this task", match: :first

    check "Completed" if @task.completed
    fill_in "Title", with: @task.title
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "should destroy Task" do
    visit task_url(@task)
    click_on "Destroy this task", match: :first

    assert_text "Task was successfully destroyed"
  end
end
