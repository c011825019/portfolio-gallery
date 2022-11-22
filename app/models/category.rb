class Category < ApplicationRecord
  has_many :portfolio_categorys, dependent: :destroy
  has_many :portfolios, through: :portfolio_categorys

  validates :name, length: { maximum: 20 }, presence: true
end
