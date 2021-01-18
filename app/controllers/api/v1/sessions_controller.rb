class Api::V1::SessionsController < ApplicationController
  def create
    user = UserFacade.auth(user_params)
    if user.nil?
      render json: { error: 'invalid credentials' }, status: 400
    else
      render json: UsersSerializer.new(user)
    end
  end

  def user_params
    params.permit(:email, :password)
  end
end
