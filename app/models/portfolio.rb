class Portfolio < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :portfolio_tags, dependent: :destroy
  has_many :tags, through: :portfolio_tags
  has_many :portfolio_categorys, dependent: :destroy
  has_many :categories, through: :portfolio_categorys

  validates :name, length: {maximum: 50 }, presence: true
  validates :outline, length: { maximum: 300 }
  validates :site_url, presence: true
  validates :code_url, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def save_tags(savebook_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savebook_tags
    new_tags = savebook_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      portfolio_tag = Tag.find_or_create_by(name:new_name)
      self.tags << portfolio_tag
    end
  end
end
