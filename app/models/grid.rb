class Grid < ApplicationRecord
  SIZE = 3
  CELLS_COUNT = SIZE * SIZE

  after_create :create_cells
  belongs_to :user
  belongs_to :opponent, class_name: "User"
  has_many :cells, -> { order(:position) }, dependent: :destroy

  enum state: { in_progress: 0, finished: 1 }

  def create_cells
    Grid::CELLS_COUNT.times do |n|
      self.cells.create!(position: n)
    end
  end
  
end
