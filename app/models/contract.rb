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

  scope :between_users, ->(first_user, second_user) {
    where(
      "(client_id = :first_user_id AND artist_id = :second_user_id) OR (client_id = :second_user_id AND artist_id = :first_user_id)",
      first_user_id: first_user.id,
      second_user_id: second_user.id
    )
  }

  def participant?(user)
    user.present? && (client_id == user.id || artist_id == user.id)
  end

  def counterparty_for(user)
    return artist if user&.id == client_id
    return client if user&.id == artist_id

    nil
  end

  def reviewed_by?(user)
    reviews.exists?(reviewer_id: user.id)
  end

  def reviewable_by?(user)
    status_completed? && participant?(user) && !reviewed_by?(user)
  end
end