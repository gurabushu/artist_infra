class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_contract
  before_action :set_reviewee
  before_action :ensure_reviewable

  def new
    @review = build_review
  end

  def create
    @review = build_review(review_params)

    if @review.save
      redirect_to user_path(@reviewee), notice: "評価を投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_contract
    @contract = Contract.includes(:project, :reviews, :client, :artist).find(params[:contract_id])
    return if @contract.participant?(current_user)

    redirect_to users_path, alert: "この契約にはアクセスできません"
  end

  def set_reviewee
    @reviewee = @contract.counterparty_for(current_user)
  end

  def ensure_reviewable
    return if @contract.reviewable_by?(current_user) && @reviewee.present?

    redirect_to user_path(@reviewee || current_user), alert: "この契約はまだ評価できません"
  end

  def build_review(attributes = {})
    Review.new(
      {
        contract: @contract,
        reviewer: current_user,
        reviewee: @reviewee
      }.merge(attributes)
    )
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end