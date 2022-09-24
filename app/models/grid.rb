class Grid < ApplicationRecord
  belongs_to :user
  belongs_to :opponent, class_name: "User"

  enum state: { in_progress: 0, finished: 1 }
end
