class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:create]

  def create
    @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    @review = current_user.reviews.new(review_params)
    @review.portfolio_id = @portfolio.id


    if @review.save
      @portfolio.update(evaluation_average: @portfolio.reviews.average(:evaluation))# review情報更新時、portfolioのreviewの評価の平均値を更新
    else
      render :error
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    @review = Review.find(params[:id])

    if @review.update(review_params)
      @portfolio.update(evaluation_average: @portfolio.reviews.average(:evaluation))# review情報更新時、portfolioのreviewの評価の平均値を更新
      redirect_to portfolio_path(params[:portfolio_id])
    else
      render 'error'
    end
  end

  def destroy
    @portfolio = Portfolio.find_by(id: params[:portfolio_id])
    Review.find_by(id: params[:id], portfolio_id: params[:portfolio_id]).destroy

    # review情報更新時、portfolioのreviewの評価の平均値を更新
    if @portfolio.reviews.find_by(portfolio_id: @portfolio.id)
      @portfolio.update(evaluation_average: @portfolio.reviews.average(:evaluation))
    else
      @portfolio.update(evaluation_average: 0)
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :evaluation)
  end

  def ensure_correct_user
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to portfolio_path(@review.portfolio)
    end
  end

  def ensure_guest_user
    @user = current_user
    @portfolio = Portfolio.find(params[:portfolio_id])
    if @user.name == "guestuser"
      redirect_to portfolio_path(@portfolio) , notice: 'ゲストユーザーはレビューを投稿できません。'
    end
  end
end
