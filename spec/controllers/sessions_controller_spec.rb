require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let!(:user) { create(:user, username: 'testuser', password: 'password') }

    context 'with valid credentials' do
      let(:valid_credentials) { { username: 'testuser', password: 'password' } }

      it 'returns a success response' do
        post :create, params: valid_credentials
        expect(response).to have_http_status(:success)
      end

      it 'returns a JWT token' do
        post :create, params: valid_credentials
        expect(response.body).to include('jwt')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { username: 'testuser', password: 'wrongpassword' } }

      it 'returns an unauthorized response' do
        post :create, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a success response' do
      delete :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
