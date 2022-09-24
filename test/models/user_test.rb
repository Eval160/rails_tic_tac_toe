require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @opponent = users(:two)
    @owned_grid = Grid.create!(user: @user, opponent: @opponent)
    @involved_grid = Grid.create!(user: @opponent, opponent: @user)
  end

  test "should find owned grids" do
    assert_includes @user.owned_grids, @owned_grid
  end

  test "should find involved grids" do
    assert_includes @user.involved_grids, @involved_grid
  end
  

  test "should return owned and involved gris" do
    assert_includes @user.grids, @owned_grid
    assert_includes @user.grids, @involved_grid
  end
end
