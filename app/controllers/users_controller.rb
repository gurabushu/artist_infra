class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :status)
end

end