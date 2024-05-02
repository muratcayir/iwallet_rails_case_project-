require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { create(:user) } # Örnek bir kullanıcı oluştur
  let(:cart) { create(:cart, user: user) } # Örnek bir alışveriş sepeti oluştur
  let(:book) { create(:book) } # Örnek bir kitap oluştur

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { cart_item: { cart_id: cart.id, book_id: book.id, quantity: 1, subtotal: book.price } } }

      it 'creates a new cart item' do
        expect {
          post :create, params: valid_params
        }.to change(CartItem, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { cart_item: { cart_id: nil, book_id: nil, quantity: nil, subtotal: nil } } }

      it 'does not create a new cart item' do
        expect {
          post :create, params: invalid_params
        }.to_not change(CartItem, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:cart_item) { create(:cart_item, cart: cart, book: book, quantity: 1, subtotal: book.price) }

    context 'with valid parameters' do
      let(:valid_params) { { id: cart_item.id, cart_item: { quantity: 2 } } }

      it 'updates the quantity of the cart item' do
        patch :update, params: valid_params
        cart_item.reload
        expect(cart_item.quantity).to eq(2)
      end

      it 'returns a success response' do
        patch :update, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { id: cart_item.id, cart_item: { quantity: nil } } }

      it 'does not update the cart item' do
        expect {
          patch :update, params: invalid_params
        }.to_not change { cart_item.reload.attributes }
      end

      it 'returns an unprocessable entity response' do
        patch :update, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cart_item) { create(:cart_item, cart: cart, book: book) }

    it 'destroys the cart item' do
      expect {
        delete :destroy, params: { id: cart_item.id }
      }.to change(CartItem, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, params: { id: cart_item.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
