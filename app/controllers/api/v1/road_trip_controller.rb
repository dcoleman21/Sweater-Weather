class Api::V1::RoadTripController < ApplicationController
  def create
    user = UserFacade.auth_key(params[:api_key])
    if user.nil?
      render json: { error: 'invalid key' }, status: 401
    else
      trip = RoadTripFacade.trip_info(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(trip)
    end
  end
end


 #<ActionController::Parameters {"origin"=>"Arvada,CO", "destination"=>"Apollo Beach, FL", #"api_key"=>"c48208d116595d67f228add960918893", "controller"=>"api/v1/road_trip", "action"=>"create", #"road_trip"=>{"origin"=>"Arvada,CO", "destination"=>"Apollo Beach, FL", "api_key"=>"c48208d116595d67f228add960918893"}} #permitted: false>
