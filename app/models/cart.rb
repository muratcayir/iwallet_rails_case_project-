class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def calculate_total_price
    self.total_price = cart_items.sum(&:subtotal)
  end
end
