class Review < ApplicationRecord
  belongs_to :contract
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"

  validates :reviewer_id, uniqueness: { scope: :contract_id, message: "はこの契約をすでに評価済みです" }
  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validate :contract_must_be_completed
  validate :reviewer_must_belong_to_contract
  validate :reviewee_must_be_contract_counterparty

  private

  def contract_must_be_completed
    return if contract.blank? || contract.status_completed?

    errors.add(:contract, "が完了していないため評価できません")
  end

  def reviewer_must_belong_to_contract
    return if contract.blank? || reviewer.blank? || contract.participant?(reviewer)

    errors.add(:reviewer, "はこの契約の当事者ではありません")
  end

  def reviewee_must_be_contract_counterparty
    return if contract.blank? || reviewer.blank? || reviewee.blank?
    return if contract.counterparty_for(reviewer) == reviewee

    errors.add(:reviewee, "は契約相手である必要があります")
  end
end