require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe '#calculate_subtotal' do
    it 'calculates the subtotal as the product of quantity and book price' do
      book = Book.create(title: 'Test Book', price: 20.00)
      cart = Cart.create(user_id: 1) # Burada user_id örnek olarak verilmiştir.
      cart_item = Cart.create(cart: cart, book: book, quantity: 3)

      cart_item.calculate_subtotal

      expect(cart_item.subtotal).to eq(60.00) # 3 * 20.00
    end
  end
end
