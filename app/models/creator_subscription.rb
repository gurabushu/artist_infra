class CreatorSubscription < ApplicationRecord
  belongs_to :subscription_plan
  belongs_to :subscriber, class_name: "User"
  belongs_to :creator, class_name: "User"

enum :status, { active: 0, canceled: 1, paused: 2 }, prefix: true


end