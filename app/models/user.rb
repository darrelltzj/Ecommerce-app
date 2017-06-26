class User < ApplicationRecord
  has_many :products
  has_many :orders

  validates :first_name, presence: true
  validates :first_name, length: { in: 1..30 }
  validates :last_name, presence: true
  validates :last_name, length: { in: 1..30 }
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, length: { in: 6..20 }, on: :create

  has_secure_password

  def self.find_and_authenticate_user(params)
    User.find_by_email(params[:email]).try(:authenticate, params[:password])
  end

end
