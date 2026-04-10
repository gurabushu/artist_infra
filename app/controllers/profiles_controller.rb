class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile
  before_action :set_dashboard_state, only: [:show, :update]

  def show
  end

  def update
    if @profile.update(profile_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy_avatar_image
    @profile.avatar_image.purge_later if @profile.avatar_image.attached?
    redirect_to mypage_path, notice: "顔写真ファイルを削除しました"
  end

  private

  def set_profile
    @profile = current_user.profile || current_user.build_profile(display_name: current_user.name)
  end

  def profile_params
    params.require(:profile).permit(
      :display_name,
      :area,
      :genre,
      :website_url,
      :bio,
      :avatar_url,
      :avatar_image
    )
  end

  def set_dashboard_state
    @billing_subscription = current_user.billing_subscriptions.order(updated_at: :desc).first
    @subscription_plan = current_user.subscription_plans.order(updated_at: :desc).first_or_initialize(active: false)
  end
end