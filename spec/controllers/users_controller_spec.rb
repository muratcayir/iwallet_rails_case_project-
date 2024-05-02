require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST /users' do
    context 'with valid attributes' do
      it 'creates a new user and returns success message' do
        post '/users', params: { user: { username: 'newuser', password: 'securepassword' } }
        expect(response).to have_http_status(:created)
        expect(response.body).to match(/User was successfully created./)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user and returns error messages' do
        post '/users', params: { user: { username: '', password: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/errors/)
      end
    end
  end
end
