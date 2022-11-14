class Public::ReviewsController < ApplicationController
  def create
    portfolio = Portfolio.find(params[:portfolio_id])
    @review = current_user.reviews.new(review_params)
    @review.portfolio_id = portfolio.id
    @review.save
    redirect_to portfolio_path(portfolio)
  end

  def destroy
    @review = Review.find_by(id: params[:id], portfolio_id: params[:portfolio_id])
    @review.destroy
    redirect_to portfolio_path(@portfolio)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :evaluation)
  end
end
