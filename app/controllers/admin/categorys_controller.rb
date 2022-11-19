class Admin::CategorysController < ApplicationController

  def index
    @categorys = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categorys_path
    else
      @categorys = Category.all
      @category = Category.new
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
      @categorys = Category.all
      @category = Category.new
      render :index
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
