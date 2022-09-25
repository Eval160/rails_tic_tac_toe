class Cell < ApplicationRecord
  belongs_to :grid
  belongs_to :user, optional: true

  validates :position, uniqueness: { scope: :grid }

  after_update :user_won?

  def position_x
    (self.position / Grid::SIZE) + 1
  end

  def position_y
    return 1 if self.position.zero?
    (self.position % Grid::SIZE + 1)
  end
  
  
  private
  
  def user_won?
    return if less_than_3_turns_by_player
    
  end

  def less_than_3_turns_by_player
    self.grid.players.all? do |player|
      self.grid.cells.where(user: player).count < 3
    end
  end
  
end
