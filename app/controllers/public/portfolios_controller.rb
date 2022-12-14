class Public::PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:new]

  def index
    @q = Portfolio.ransack(params[:q])
    @portfolios = @q.result.page(params[:page]).per(6)
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @q = @portfolio.reviews.ransack(params[:q])
    @reviews = @q.result
    @review = Review.new

    # 非公開時、投稿ユーザー以外の閲覧を制限
    redirect_to portfolios_path if !@portfolio.is_public && @portfolio.user != current_user
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    tag_list=params[:portfolio][:tag_name].split(',')

    if @portfolio.save
      @portfolio.save_tags(tag_list) if tag_list.length <= 5
      redirect_to portfolio_path(@portfolio)
    else
      @tag_list=tag_list.join(',')
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
      @portfolio.save_tags(tag_list) if tag_list.length <= 5
      redirect_to portfolio_path(@portfolio)
    else
      @tag_list=@portfolio.tags.pluck(:name).join(',')
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
    params.require(:portfolio).permit(:name, :image, :outline, :site_url, :code_url, :is_public, category_ids: [])
  end

  def ensure_correct_user
    @portfolio = Portfolio.find(params[:id])
    unless @portfolio.user == current_user
      redirect_to portfolios_path
    end
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to portfolios_path , notice: 'ゲストユーザーは新規投稿画面へ遷移できません。'
    end
  end
end
