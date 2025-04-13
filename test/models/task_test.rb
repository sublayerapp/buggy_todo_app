require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "tags can be assigned to a task" do
    task = Task.new(title: "Test Task", completed: false, tags: ["tag1", "tag2"])
    assert task.valid?
    assert_equal ["tag1", "tag2"], task.tags
  end
end
