class Language < ApplicationRecord
  has_many :portfolio_languages, dependent: :destroy
  has_many :portfolios, through: :portfolio_languages
end
