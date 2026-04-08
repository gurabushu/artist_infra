class JobApplication  < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :status, { pending: 0, accepted: 1, rejected: 2, withdrawn: 3 }, prefix: true

  validates :proposal, presence: true
end