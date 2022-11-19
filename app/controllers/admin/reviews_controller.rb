class Admin::ReviewsController < ApplicationController

  def destroy
    Review.find_by(id: params[:id], portfolio_id: params[:portfolio_id]).destroy
    redirect_to admin_portfolio_path(params[:portfolio_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :evaluation)
  end
end
