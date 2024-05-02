require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { create(:user) } 

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { cart: { user_id: user.id } } }

      it 'creates a new cart' do
        expect {
          post :create, params: valid_params
        }.to change(Cart, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { cart: { user_id: nil } } }

      it 'does not create a new cart' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Cart, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:cart) { create(:cart, user: user) }

    context 'with valid parameters' do
      let(:valid_params) { { id: cart.id, cart: { user_id: user.id + 1 } } }

      it 'updates the user of the cart' do
        patch :update, params: valid_params
        cart.reload
        expect(cart.user_id).to eq(user.id + 1)
      end

      it 'returns a success response' do
        patch :update, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { id: cart.id, cart: { user_id: nil } } }

      it 'does not update the cart' do
        expect {
          patch :update, params: invalid_params
        }.to_not change { cart.reload.attributes }
      end

      it 'returns an unprocessable entity response' do
        patch :update, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cart) { create(:cart, user: user) }

    it 'destroys the cart' do
      expect {
        delete :destroy, params: { id: cart.id }
      }.to change(Cart, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, params: { id: cart.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
