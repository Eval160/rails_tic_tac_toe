class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_grids, class_name: "Grid", foreign_key: "user_id", dependent: :destroy
  has_many :involved_grids, class_name: "Grid", foreign_key: "opponent_id", dependent: :destroy

  def grids
    Grid.where("user_id = :user OR opponent_id = :user", user: self.id)
  end

  def self.ia
    User.find_by(email: "ia@mail.com")
  end
  
end
