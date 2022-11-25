class Public::HomesController < ApplicationController
  def top
    @portfolios = Portfolio.order('evaluation_average DESC').limit(4)
  end
end
