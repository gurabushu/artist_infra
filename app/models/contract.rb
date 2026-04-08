class Contract < ApplicationRecord
  belongs_to :project
  belongs_to :client, class_name: "User"
  belongs_to :artist, class_name: "User"

  has_many :reviews, dependent: :destroy

  enum :contract_type, {
    one_time: 0,
    subscription: 1
  }, prefix: true

  enum :status, {
    active: 0,
    completed: 1,
    canceled: 2,
    paused: 3
  }, prefix: true

  validates :agreed_amount, numericality: { only_integer: true }, allow_nil: true
end