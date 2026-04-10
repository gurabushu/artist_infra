class CreatorSubscriptionsController < ApplicationController
  before_action :require_login
  before_action :set_creator

  def create
    if @creator == current_user
      redirect_to user_path(@creator), alert: "自分自身には申し込めません"
      return
    end

    subscription_plan = @creator.active_subscription_plan
    unless subscription_plan.present?
      redirect_to user_path(@creator), alert: "このユーザーは継続案件をまだ受け付けていません"
      return
    end

    subscription = current_user.creator_subscriptions_as_subscriber
                               .where(creator: @creator)
                               .order(updated_at: :desc)
                               .first_or_initialize

    if subscription.update(subscription_plan: subscription_plan, status: :active, started_on: Date.current, canceled_on: nil)
      redirect_to user_path(@creator), notice: "継続案件の申し込みを開始しました"
    else
      redirect_to user_path(@creator), alert: subscription.errors.full_messages.to_sentence.presence || "継続案件の申し込みに失敗しました"
    end
  end

  private

  def set_creator
    @creator = User.find(params[:user_id])
  end
end