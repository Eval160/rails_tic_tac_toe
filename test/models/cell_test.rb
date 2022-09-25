require "test_helper"

class CellTest < ActiveSupport::TestCase
  test "position should be unique in grid scope" do
    grid = Grid.create!(user: User.first, opponent: User.last)
    cell_to_update = grid.cells.last
    cell_to_update.position = grid.cells.first.position
    assert_not cell_to_update.valid?
    assert cell_to_update.errors[:position].present?, "should have an error to position attribute"
    assert cell_to_update.errors.details[:position].any?{|e| e[:error] == :taken}, "should have taken error"
  end
end
