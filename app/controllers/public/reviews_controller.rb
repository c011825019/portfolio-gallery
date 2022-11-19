class Public::ReviewsController < ApplicationController
  def create
    portfolio = Portfolio.find(params[:portfolio_id])
    @review = current_user.reviews.new(review_params)
    @review.portfolio_id = portfolio.id
    @review.save
    redirect_to portfolio_path(portfolio)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to portfolio_path(params[:portfolio_id])
    else
      render :edit
    end
  end

  def destroy
    Review.find_by(id: params[:id], portfolio_id: params[:portfolio_id]).destroy
    redirect_to portfolio_path(params[:portfolio_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :evaluation)
  end
end
