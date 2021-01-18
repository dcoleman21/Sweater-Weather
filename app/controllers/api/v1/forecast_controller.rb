class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast_by_coords(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end
