class Review < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio

  validates :comment, length: { minimum: 1, maximum: 300 }, presence: true
  validates :evaluation, presence: true
end
