class Product < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :name, length: { in: 1..30 }
  validates :original_price, numericality: {greater_than: 0}
  validates :discounted_price, numericality: {greater_than: 0}

  validate :original_greater_than_discount

  def original_greater_than_discount
    errors.add(:original_price, "must be more than or equal to discounted price") unless original_price >= discounted_price
  end

end
