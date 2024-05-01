class PaymentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user_cart, only: [:process_payment]

  # POST /process_payment
  def process_payment
    # Kullanıcının sepetindeki öğeleri al
    cart_items = @user_cart.cart_items.includes(:book)
    
    # Sepet öğeleri ve toplam tutarı işle
    total_price = calculate_total(cart_items)
    
    # Ödeme işlemini simüle et (örneğin, kredi kartı doğrulaması)
    payment_success = simulate_payment(total_price)
    
    if payment_success
      # Ödeme başarılı ise sepeti temizle
      @user_cart.cart_items.destroy_all
      render json: { message: 'Payment successful' }, status: :ok
    else
      render json: { error: 'Payment failed' }, status: :unprocessable_entity
    end
  end

  private

  # Kullanıcının sepetini bul
  def set_user_cart
    @user_cart = current_user.cart
  end

  # Toplam tutarı hesapla
  def calculate_total(cart_items)
    total_price = 0
    cart_items.each do |cart_item|
      total_price += cart_item.book.price * cart_item.quantity
    end
    total_price
  end

  # Ödeme işlemini simüle et
  def simulate_payment(total_price)
    # Ödeme işlemi başarılı ise true dön
    # Burada örnek bir kredi kartı doğrulaması yapılabilir
    # Gerçek bir ödeme işlemi için ödeme işlemi entegrasyonu gereklidir
    # Bu örnek sadece bir simülasyondur
    true
  end
end
