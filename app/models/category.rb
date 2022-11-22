class Category < ApplicationRecord
  has_many :portfolio_categorys, dependent: :destroy
  has_many :portfolios, through: :portfolio_categorys
end
