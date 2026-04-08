class Scout < ApplicationRecord
  belongs_to :project
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  enum :status, { pending: 0, accepted: 1, declined: 2 }, prefix: true

  validates :message, presence: true
end