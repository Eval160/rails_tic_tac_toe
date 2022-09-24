class Cell < ApplicationRecord
  belongs_to :grid
  belongs_to :user, optional: true
end
