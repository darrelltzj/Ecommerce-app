class Product < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :name, length: { in: 1..30 }
  validates :original_price, numericality: {greater_than: 0}
  validates :discounted_price, numericality: {greater_than: 0}

  validate :original_greater_than_discount

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '600x600>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def original_greater_than_discount
    errors.add(:original_price, "must be more than or equal to discounted price") unless original_price >= discounted_price
  end

end
