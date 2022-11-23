class Review < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio

  validates :evaluation, presence: true
  validates :comment, length: { maximum: 300 }, presence: true
end
