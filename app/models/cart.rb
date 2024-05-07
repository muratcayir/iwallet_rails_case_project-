class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :books, through: :cart_items

  # Kitap ekler veya var olan kitabın miktarını günceller
  def add_book(book, quantity)
    current_item = cart_items.find_by(book_id: book.id)
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      current_item = cart_items.create(book_id: book.id, quantity: quantity)
    end
    current_item
  end

  def checkout
    # Ödeme işlemi burada simüle edilir. Gerçek bir uygulamada ödeme gateway'ine istek yapılabilir.
    # Ödeme başarılı olarak kabul edilirse, sepeti temizle.
    clear_cart_items
    true
  end

  private

  def clear_cart_items
    cart_items.destroy_all
  end
end
