require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'GET #authenticate_request!' do
    context 'with valid JWT token' do
      let!(:user) { create(:user) }
      let(:valid_jwt) { JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base) }

      before do
        request.headers['Authorization'] = "Bearer #{valid_jwt}"
      end

      it 'sets current_user' do
        controller.authenticate_request!
        expect(controller.instance_variable_get(:@current_user)).to eq(user)
      end
    end

    context 'with invalid JWT token' do
      before do
        request.headers['Authorization'] = 'Bearer invalidtoken'
      end

      it 'returns an unauthorized response' do
        controller.authenticate_request!
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
