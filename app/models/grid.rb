class Grid < ApplicationRecord
  SIZE = 3
  CELLS_COUNT = SIZE * SIZE

  after_create :create_cells
  belongs_to :user
  belongs_to :opponent, class_name: "User"
  has_many :cells, -> { order(:position) }, dependent: :destroy

  enum state: { in_progress: 0, finished: 1 }

  def players
    [self.user, self.opponent]
  end
  
  def create_cells
    Grid::CELLS_COUNT.times do |n|
      self.cells.create!(position: n)
    end
  end

  def user_who_plays
    if self.cells.pluck(:user_id).all?(&:nil?)
      self.user
    else
      players = self.players
      last_user_who_plays = self.cells.unscope(:order).order(:updated_at).last.user
      players.find{|user| user != last_user_who_plays }
    end
  end
  
end
