class Api::V1::RoadTripController < ApplicationController
  def create
    user = UserFacade.auth_key(params[:api_key])
    if user.nil?
      render json: { error: 'Unable To Authenticate' }, status: 401
    else
      trip = RoadTripFacade.trip_info(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(trip)
    end
  end
end
