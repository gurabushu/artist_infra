class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  validates :level, numericality: { only_integer: true }, allow_nil: true
  validates :skill_id, uniqueness: { scope: :user_id }
end