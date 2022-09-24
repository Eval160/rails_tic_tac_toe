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

  test "should generate 6 cells after grid creation" do
    grid = Grid.create!(user: @user, opponent: @opponent)
    assert_equal 6, grid.cells.count
  end

  test "should order grid's cells by position" do
    grid = Grid.create!(user: @user, opponent: @opponent)
    6.times do |n|
      assert_equal n, grid.cells[n].position, "should be at position #{n}"
    end
  end
end
