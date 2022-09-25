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

  def all_cells_played?
    self.cells.all?{|c| c.user_id?}
  end
  
  def auto_play
    return if self.unplayed_cells.empty?
    cell = self.unplayed_cells.sample
    cell.update(user: User.ia)
  end

  def winner
    return nil unless self.finished?

    self.cells.unscope(:order).order(:updated_at).last.user
  end
  
  
end
