class SubscriptionPlan < ApplicationRecord
  belongs_to :user

  has_many :creator_subscriptions, dependent: :destroy

  validates :title, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :active_plan_requires_creator_eligibility

  scope :active_only, -> { where(active: true) }

  private

  def active_plan_requires_creator_eligibility
    return unless active?
    return if user&.can_offer_continuous_work?

    errors.add(:active, "はシルバーランク以上かつアプリ課金中のユーザーのみ有効化できます")
  end
end