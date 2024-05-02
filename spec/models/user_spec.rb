require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(username: 'testuser', password: 'password123')
      expect(user).to be_valid
    end

    it 'is invalid without a username' do
      user = User.new(password: 'password123')
      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user = User.new(username: 'testuser')
      expect(user).to_not be_valid
    end
  end
end
