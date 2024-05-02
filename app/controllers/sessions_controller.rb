class SessionsController < ApplicationController
  include ActionController::Cookies

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = generate_jwt(user)
      cookies.signed[:jwt] = { value: token, httponly: true }
      render json: { jwt: token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    cookies.delete(:jwt)
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def generate_jwt(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)
  end
end
