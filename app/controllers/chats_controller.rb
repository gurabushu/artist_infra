class ChatsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :prevent_self_chat
  before_action :require_match

  def show
    @messages = Message.between(current_user, @user).chronological.with_attached_files
    @message = Message.new
  end

  def create
    @message = current_user.sent_messages.build(message_params.merge(recipient: @user))
    @messages = Message.between(current_user, @user).chronological.with_attached_files

    if @message.save
      redirect_to chat_user_path(@user), notice: "メッセージを送信しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def prevent_self_chat
    return unless @user == current_user

    redirect_to user_path(@user), alert: "自分自身とはチャットを開始できません"
  end

  def require_match
    return if current_user.matched_with?(@user)

    redirect_to user_path(@user), alert: "相互にいいねした相手とだけチャットできます"
  end

  def message_params
    params.require(:message).permit(:body, files: [])
  end
end