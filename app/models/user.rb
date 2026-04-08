class User < ApplicationRecord
  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :pro_account, dependent: :destroy

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :works, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :billing_subscriptions, dependent: :destroy
  has_many :subscription_plans, dependent: :destroy

  has_many :contracts_as_client,
           class_name: "Contract",
           foreign_key: :client_id,
           dependent: :destroy

  has_many :contracts_as_artist,
           class_name: "Contract",
           foreign_key: :artist_id,
           dependent: :destroy

  has_many :reviews_written,
           class_name: "Review",
           foreign_key: :reviewer_id,
           dependent: :destroy

  has_many :reviews_received,
           class_name: "Review",
           foreign_key: :reviewee_id,
           dependent: :destroy

  has_many :creator_subscriptions_as_subscriber,
           class_name: "CreatorSubscription",
           foreign_key: :subscriber_id,
           dependent: :destroy

  has_many :creator_subscriptions_as_creator,
           class_name: "CreatorSubscription",
           foreign_key: :creator_id,
           dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :target_user

  has_many :reverse_favorites,
           class_name: "Favorite",
           foreign_key: :target_user_id,
           dependent: :destroy

  has_many :followers, through: :reverse_favorites, source: :user

  has_many :sent_scouts,
           class_name: "Scout",
           foreign_key: :sender_id,
           dependent: :destroy

  has_many :received_scouts,
           class_name: "Scout",
           foreign_key: :receiver_id,
           dependent: :destroy

  enum :role, { artist: 0, client: 1 }, prefix: true
  enum :status, { inactive: 0, active: 1, suspended: 2 }, prefix: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end