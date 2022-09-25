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

  test "should return x and y coordonates" do
    grid = Grid.create!(user: User.first, opponent: User.last)

    grid.cells.each_slice(Grid::SIZE).with_index do |row, y|
      position_y = y + 1
      row.each_with_index do |cell, x|
        position_x = x + 1
        assert_equal position_x, cell.position_x
        assert_equal position_y, cell.position_y
      end
    end
  end
end
