require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { book: { title: 'Test Book', author: 'Test Author', publisher: 'Test Publisher', price: 9.99 } } }

      it 'creates a new book' do
        expect {
          post :create, params: valid_params
        }.to change(Book, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { book: { title: '', author: 'Test Author', publisher: 'Test Publisher', price: 9.99 } } }

      it 'does not create a new book' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Book, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
