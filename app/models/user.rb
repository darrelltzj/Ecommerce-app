class User < ApplicationRecord
  has_many :products
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, length: { in: 6..20 }, on: :create
  validates :is_seller, presence: true
  validates :is_active, presence: true

  has_secure_password

  def self.find_and_authenticate_user(params)
    User.find_by_email(params[:email]).try(:authenticate, params[:password])
  end

end
