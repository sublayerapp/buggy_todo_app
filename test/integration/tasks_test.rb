require "test_helper"

class TasksTest < ActionDispatch::IntegrationTest
  test "index only shows incomplete tasks" do
    # Create a completed task
    completed_task = Task.create!(title: "Completed task", completed: true)
    
    # Create an incomplete task
    incomplete_task = Task.create!(title: "Incomplete task", completed: false)
    
    get tasks_url
    
    # Verify the incomplete task is shown
    assert_match incomplete_task.title, response.body
    
    # Verify the completed task is not shown
    assert_no_match completed_task.title, response.body
  end
end
