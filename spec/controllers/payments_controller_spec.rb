require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book) }
  let(:cart_item) { create(:cart_item, cart: cart, book: book, quantity: 2) }

  before do
    allow(controller).to receive(:authenticate_request!) # authenticate_request! metodunu geçersiz kıl
    allow(controller).to receive(:current_user).and_return(user) # current_user metodunu kullanıcıyı döndürecek şekilde geçersiz kıl
  end

  describe 'POST #process_payment' do
    context 'when payment is successful' do
      before do
        allow_any_instance_of(Cart).to receive(:total_price).and_return(50) # Sepetin toplam fiyatını ayarla
        allow_any_instance_of(PaymentsController).to receive(:simulate_payment).and_return(true) # Ödeme simülasyonunu başarılı dön
        allow(cart.cart_items).to receive(:destroy_all) # CartItems modelindeki destroy_all metodunu geçersiz kıl
      end

      it 'destroys all cart items' do
        post :process_payment
        expect(cart.cart_items).to have_received(:destroy_all)
      end

      it 'returns a success response' do
        post :process_payment
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when payment fails' do
      before do
        allow_any_instance_of(Cart).to receive(:total_price).and_return(50)
        allow_any_instance_of(PaymentsController).to receive(:simulate_payment).and_return(false) 
      end

      it 'does not destroy any cart items' do
        post :process_payment
        expect(cart.cart_items).not_to have_received(:destroy_all)
      end

      it 'returns an unprocessable entity response' do
        post :process_payment
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
