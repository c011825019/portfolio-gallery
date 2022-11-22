class Tag < ApplicationRecord
  has_many :portfolio_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :portfolios, through: :portfolio_tags
end
