class SubscriptionPlan < ApplicationRecord
  belongs_to :user

  has_many :creator_subscriptions, dependent: :destroy

  validates :title, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :active_only, -> { where(active: true) }
end