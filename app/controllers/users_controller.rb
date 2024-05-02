class UsersController < ApplicationController
  def new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User was successfully created.' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
