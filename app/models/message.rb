class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", inverse_of: :sent_messages
  belongs_to :recipient, class_name: "User", inverse_of: :received_messages
  has_many_attached :files

  validates :body, length: { maximum: 1000 }
  validate :sender_and_recipient_must_differ
  validate :body_or_files_present

  scope :between, lambda { |user_a, user_b|
    where(sender: user_a, recipient: user_b)
      .or(where(sender: user_b, recipient: user_a))
  }
  scope :chronological, -> { order(created_at: :asc) }

  private

  def sender_and_recipient_must_differ
    return if sender_id != recipient_id

    errors.add(:recipient_id, "は送信者と同じにできません")
  end

  def body_or_files_present
    return if body.present? || files.attached?

    errors.add(:base, "メッセージ本文またはファイルを追加してください")
  end
end