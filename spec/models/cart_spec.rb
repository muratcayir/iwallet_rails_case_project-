require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#calculate_total_price' do
    it 'calculates the total price based on cart items subtotals' do
      user = User.create(username: 'testuser', password: 'password')
      cart = Cart.create(user: user)
      cart.cart_items.create(price: 10, quantity: 2) # subtotal = 20
      cart.cart_items.create(price: 15, quantity: 1) # subtotal = 15

      cart.calculate_total_price

      expect(cart.total_price).to eq(35)
    end
  end
end
