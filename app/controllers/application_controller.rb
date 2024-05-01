class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate_request!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode(header, Rails.application.secret_key_base)
      @current_user = User.find(@decoded[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
