class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  private


  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = decode_jwt(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: "Access denied" }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: "Access denied" }, status: :unauthorized
    end
  end
  def decode_jwt(token)
    body = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new body
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise JWT::DecodeError, e.message
  end
end