class PaymentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user_cart, only: [:process_payment]

  # POST /process_payment
  def process_payment
   
    # Toplam sepet tutarı hesapla
    cart_total_price = @user_cart.total_price
    
    # Ödeme işlemini simüle et (örneğin, kredi kartı doğrulaması)
    payment_success = simulate_payment(cart_total_price)
    
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


  # Ödeme işlemini simüle et
  def simulate_payment(total_price)
    # Ödeme işlemi başarılı ise true dön
    # Burada örnek bir kredi kartı doğrulaması yapılabilir
    # Gerçek bir ödeme işlemi için ödeme işlemi entegrasyonu gereklidir
    # Bu örnek sadece bir simülasyondur
    true
  end
end
