class Grid < ApplicationRecord
  SIZE = 3
  CELLS_COUNT = SIZE * SIZE

  after_create :create_cells
  belongs_to :user
  belongs_to :opponent, class_name: "User"
  has_many :cells, -> { order(:position) }, dependent: :destroy
  has_many :unplayed_cells, -> { where(user: nil)}, class_name: "Cell", foreign_key: "grid_id"
  has_many :played_cells, -> { where.not(user: nil)}, class_name: "Cell", foreign_key: "grid_id"

  enum state: { in_progress: 0, finished: 1, draw: 2 }

  def players
    [self.user, self.opponent]
  end
  
  def create_cells
    Grid::CELLS_COUNT.times do |n|
      self.cells.create!(position: n)
    end
  end

  def user_who_plays
    return self.user if self.cells.pluck(:user_id).all?(&:nil?)

    players = self.players
    last_user_who_plays = self.cells.unscope(:order).order(:updated_at).last.user
    players.find{|user| user != last_user_who_plays }
  end

  def next_cell_to_play
    last_played_cell = self.played_cells.unscope(:order).order(:updated_at).last

    Grid::SIZE.times do |n|
      if self.played_cells.where(user: User.ia).by_row(n + 1).count == 2
        return self.unplayed_cells.by_row(n + 1).first
      elsif self.played_cells.where(user: User.ia).by_column(n + 1).count == 2
        return self.unplayed_cells.by_column(n + 1).first
      end
    end

    if self.played_cells.by_row(last_played_cell.position_y) == 2
      return self.unplayed_cells.by_row(last_played_cell.position_y).first
    elsif self.played_cells.by_column(last_played_cell.position_x) == 2
      return self.unplayed_cells.by_column(last_played_cell.position_x).first
    else
      return self.unplayed_cells.sample
    end
  end
  
  
  def auto_play
    return if self.unplayed_cells.empty?
    cell = next_cell_to_play
    cell.update(user: User.ia)
  end

  def winner
    return nil unless self.finished?

    self.cells.unscope(:order).order(:updated_at).last.user
  end
  
  
end
