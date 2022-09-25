class Cell < ApplicationRecord
  belongs_to :grid
  belongs_to :user, optional: true

  validates :position, uniqueness: { scope: :grid }

  scope :by_row, -> (n) { where("(position / :grid_size) + 1 = :n", grid_size: Grid::SIZE, n: n)}
  scope :by_column, -> (n) { where("(position % :grid_size) + 1 = :n", grid_size: Grid::SIZE, n: n)}

  after_commit :winning_move?

  def position_x
    (self.position / Grid::SIZE) + 1
  end

  def position_y
    return 1 if self.position.zero?
    (self.position % Grid::SIZE + 1)
  end
  
  
  private
  
  def winning_move?
    return if self.user.nil? || less_than_3_cells
    grid = self.grid
    user_cells = grid.cells.where(user: self.user)
    position_x = self.position_x
    position_y = self.position_y

    if all_cells_in_row(user_cells, position_x)  || all_cells_in_column(user_cells, position_y) || all_cells_in_diagonal(user_cells)
      grid.finished!
    elsif grid.unplayed_cells.count.zero?
      grid.draw!
    end
  end

  def all_cells_in_row(cells, n)
    cells.by_row(n).count > 2 
  end
  
  def all_cells_in_column(cells, n)
    cells.by_column(n).count > 2
  end

  def all_cells_in_diagonal(cells)
    [0, 4, 8].all? { |i| cells.pluck(:position).include?(i) } || 
    [2, 4, 6].all? { |i| cells.pluck(:position).include?(i) }
  end
  
  def less_than_3_cells
    self.grid.cells.where(user: self.user).count < 3
  end
  
end
