class User < ApplicationRecord
  ROLE_LABELS = {
    artist: "クリエイター",
    client: "依頼者",
    singer: "歌手",
    illustrator: "イラストレーター",
    designer: "デザイナー",
    video_creator: "動画クリエイター",
    photographer: "フォトグラファー",
    writer: "ライター",
    composer: "作曲家",
    voice_actor: "声優",
    actor: "俳優",
    model: "モデル"
  }.freeze

  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :pro_account, dependent: :destroy

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :works, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :sent_messages,
           class_name: "Message",
           foreign_key: :sender_id,
           dependent: :destroy,
           inverse_of: :sender

  has_many :received_messages,
           class_name: "Message",
           foreign_key: :recipient_id,
           dependent: :destroy,
           inverse_of: :recipient
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

  enum :role,
       {
         artist: 0,
         client: 1,
         singer: 2,
         illustrator: 3,
         designer: 4,
         video_creator: 5,
         photographer: 6,
         writer: 7,
         composer: 8,
         voice_actor: 9,
         actor: 10,
         model: 11
       },
       prefix: true
  enum :status, { inactive: 0, active: 1, suspended: 2 }, prefix: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def role_label
    ROLE_LABELS[role&.to_sym] || "-"
  end

  def liked?(other_user)
    favorites.exists?(target_user: other_user)
  end

  def matched_with?(other_user)
    return false if other_user.blank? || other_user == self

    liked?(other_user) && other_user.liked?(self)
  end

  def matched_users
    User.joins(:favorites)
        .where(favorites: { target_user_id: id })
        .where(id: favorites.select(:target_user_id))
        .distinct
  end
end