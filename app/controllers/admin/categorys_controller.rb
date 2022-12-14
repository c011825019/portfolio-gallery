class Admin::CategorysController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categorys = Category.all.page(params[:page]).per(20)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categorys_path
    else
      @categorys = Category.all.page(params[:page]).per(20)
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categorys_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categorys_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
