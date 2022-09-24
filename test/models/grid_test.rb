require "test_helper"

class GridTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @opponent = users(:two)
  end
  
  test "should belong an user and an opponent" do
    grid = Grid.new(user: @user, opponent: @opponent)
    assert_equal @opponent, grid.opponent
    assert_equal @user, grid.user
  end

  test "should be in progress by default" do
    grid = Grid.new(user: @user, opponent: @opponent)
    assert grid.in_progress?
  end
end
