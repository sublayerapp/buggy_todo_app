require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  test "visiting the index shows only incomplete tasks" do
    Task.create!(title: "Incomplete Task", completed: false)
    Task.create!(title: "Completed Task", completed: true)

    visit tasks_url
    assert_selector "div#tasks", count: 1
    assert_text "Incomplete Task"
    refute_text "Completed Task"
  end
  setup do
    @task = tasks(:one)
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
