class BillingSubscription < ApplicationRecord
  belongs_to :user

  enum :status, {
    inactive: 0,
    active: 1,
    canceled: 2,
    past_due: 3
  }, prefix: true
end