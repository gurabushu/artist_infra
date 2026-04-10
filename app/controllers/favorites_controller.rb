class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def create
    current_user.favorites.find_or_create_by!(target_user: @user)
    notice = current_user.matched_with?(@user) ? "マッチしました。チャットを始められます" : "いいねしました"
    redirect_to user_path(@user), notice: notice
  end

  def destroy
    current_user.favorites.find_by(target_user: @user)&.destroy
    redirect_to user_path(@user), notice: "いいねを解除しました"
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end