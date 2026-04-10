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

  RANK_LABELS = {
    beginner: "ビギナー",
    bronze: "ブロンズ",
    silver: "シルバー",
    gold: "ゴールド"
  }.freeze

  RANK_REQUIREMENTS = {
    beginner: { completed_contracts: 0, review_count: 0, average_rating: 0.0 },
    bronze: { completed_contracts: 1, review_count: 1, average_rating: 3.0 },
    silver: { completed_contracts: 5, review_count: 3, average_rating: 4.0 },
    gold: { completed_contracts: 12, review_count: 8, average_rating: 4.6 }
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

  def rank_label
    RANK_LABELS[current_rank]
  end

  def current_rank
    return :gold if qualified_for_rank?(:gold)
    return :silver if qualified_for_rank?(:silver)
    return :bronze if qualified_for_rank?(:bronze)

    :beginner
  end

  def received_review_count
    reviews_received.count
  end

  def average_received_rating
    reviews_received.average(:rating).to_f.round(1)
  end

  def completed_contracts_count
    contracts_as_artist.status_completed.count
  end

  def active_app_subscription?
    billing_subscriptions
      .status_active
      .where("current_period_end IS NULL OR current_period_end >= ?", Time.current)
      .exists?
  end

  def silver_rank_or_higher?
    [:silver, :gold].include?(current_rank)
  end

  def can_offer_continuous_work?
    silver_rank_or_higher? && active_app_subscription?
  end

  def active_subscription_plan
    return unless can_offer_continuous_work?

    subscription_plans.active_only.order(updated_at: :desc).first
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

  private

  def qualified_for_rank?(rank)
    requirement = RANK_REQUIREMENTS.fetch(rank)

    completed_contracts_count >= requirement[:completed_contracts] &&
      received_review_count >= requirement[:review_count] &&
      average_received_rating >= requirement[:average_rating]
  end
end