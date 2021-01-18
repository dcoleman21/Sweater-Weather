class Api::V1::UsersController < ApplicationController
  def create
    user = UserFacade.create(user_params)
    if user.id.nil?
      render json: { errors: user.errors.full_messages.to_sentence }, status: 401
    else
      render json: UsersSerializer.new(user), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
