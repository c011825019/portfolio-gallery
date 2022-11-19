class Admin::ReviewsController < ApplicationController

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
end
