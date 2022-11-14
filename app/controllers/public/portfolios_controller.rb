class Public::PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    if @portfolio.save
      redirect_to portfolio_path(@portfolio)
    else
      @portfolios = Portfolio.all
      render :index
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :image, :outline, :url)
  end
end
