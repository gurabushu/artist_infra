class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, class_name: "User"

  validates :target_user_id, uniqueness: { scope: :user_id }
  
end