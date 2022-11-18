class Public::PortfoliosController < ApplicationController
  def index
    @q = Portfolio.ransack(params[:q])
    @portfolios = @q.result(distinct: true)
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @reviews = Review.all
    @review = Review.new
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    tag_list=params[:portfolio][:tag_name].split(',')
    if @portfolio.save and tag_list.length <= 5
      @portfolio.save_tags(tag_list)
      redirect_to portfolio_path(@portfolio)
    else
      render :new
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @tag_list=@portfolio.tags.pluck(:name).join(',')
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    tag_list=params[:portfolio][:tag_name].split(',')
    if @portfolio.update(portfolio_params)
      @portfolio.save_tags(tag_list)
      redirect_to portfolio_path(@portfolio)
    else
      render :edit
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    redirect_to portfolios_path
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :image, :outline, :url, :is_public, category_ids: [])
  end
end
