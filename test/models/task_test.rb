require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should have many tags" do
    task = tasks(:one)
    assert_not_empty task.tags
  end
  # test "the truth" do
  #   assert true
  # end
end
