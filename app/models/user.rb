class User < ApplicationRecord
  after_create :create_default_cart
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  has_one :cart, dependent: :destroy
  private

  def create_default_cart
    Cart.create(user: self)
  end
end