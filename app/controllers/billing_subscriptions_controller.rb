class BillingSubscriptionsController < ApplicationController
  before_action :require_login

  def create
    subscription = current_user.billing_subscriptions.order(updated_at: :desc).first_or_initialize

    if subscription.update(
      plan_name: "継続案件機能",
      status: :active,
      current_period_start: Time.current,
      current_period_end: 1.month.from_now,
      payment_provider: "manual"
    )
      redirect_to mypage_path, notice: "継続案件機能の課金を有効化しました"
    else
      redirect_to mypage_path, alert: "課金状態を更新できませんでした"
    end
  end

  def destroy
    subscription = current_user.billing_subscriptions.status_active.order(updated_at: :desc).first

    if subscription.present?
      subscription.update(status: :canceled, current_period_end: Time.current)
      redirect_to mypage_path, notice: "継続案件機能の課金を停止しました"
    else
      redirect_to mypage_path, alert: "停止対象の課金がありません"
    end
  end
end