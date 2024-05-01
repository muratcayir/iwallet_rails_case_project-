class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  
  def calculate_subtotal
    self.subtotal = quantity * book.price
  end
end

