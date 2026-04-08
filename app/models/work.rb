class Work < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :work_type, presence: true
end