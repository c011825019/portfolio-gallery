class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  after_action :update_portfolio_review_average, only: [:update, :destroy]

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_portfolio_path(params[:portfolio_id])
    else
      render :edit
    end
  end

  def destroy
    Review.find_by(id: params[:id], portfolio_id: params[:portfolio_id]).destroy
    redirect_to admin_portfolio_path(params[:portfolio_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :evaluation)
  end

  # レビュー情報更新後にポートフォリオのレビューの平均値を更新
  def update_portfolio_review_average
    portfolio = Portfolio.find(params[:portfolio_id])

    if portfolio.reviews.find_by(portfolio_id: portfolio.id)
      portfolio.update(evaluation_average: portfolio.reviews.average(:evaluation))
    else
      portfolio.update(evaluation_average: 0)
    end
  end
end
