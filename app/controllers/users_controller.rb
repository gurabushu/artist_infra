class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :matches]
  before_action :set_user, only: [:show]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @profile = @user.profile
    @favorite = current_user.favorites.find_by(target_user: @user) unless current_user == @user
    @favorite_count = @user.reverse_favorites.count
    @works = @user.works.where(published: true).order(updated_at: :desc)
    @matched = current_user.matched_with?(@user) if current_user != @user
  end

  def matches
    @matched_users = current_user.matched_users.includes(:profile)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path,notice: "登録完了"
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :status)
  end

end