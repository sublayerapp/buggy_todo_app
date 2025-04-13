require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should create tags from tag_list" do
    task = Task.create!(title: "Test task", tag_list: "urgent, important")
    assert_equal 2, task.tags.count
    assert_equal ["important", "urgent"], task.tags.pluck(:name).sort
  end

  test "should handle empty tag list" do
    task = Task.create!(title: "Test task", tag_list: "")
    assert_equal 0, task.tags.count
  end

  test "should handle duplicate tags" do
    task = Task.create!(title: "Test task", tag_list: "urgent, urgent")
    assert_equal 1, task.tags.count
  end
end
