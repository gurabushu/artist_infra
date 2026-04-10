class SubscriptionPlansController < ApplicationController
  before_action :require_login
  before_action :set_profile_dashboard_state

  def create
    @subscription_plan.assign_attributes(subscription_plan_params)

    if @subscription_plan.save
      redirect_to mypage_path, notice: plan_notice_message
    else
      render "profiles/show", status: :unprocessable_entity
    end
  end

  def update
    @subscription_plan.assign_attributes(subscription_plan_params)

    if @subscription_plan.save
      redirect_to mypage_path, notice: plan_notice_message
    else
      render "profiles/show", status: :unprocessable_entity
    end
  end

  private

  def set_profile_dashboard_state
    @profile = current_user.profile || current_user.build_profile(display_name: current_user.name)
    @billing_subscription = current_user.billing_subscriptions.order(updated_at: :desc).first
    @subscription_plan = current_user.subscription_plans.order(updated_at: :desc).first_or_initialize(active: false)
  end

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :price, :cycle, :delivery_detail, :active)
  end

  def plan_notice_message
    @subscription_plan.active? ? "継続案件プランを公開しました" : "継続案件プランを保存しました"
  end
end