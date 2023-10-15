class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show update edit destroy]

  def index
    @itineraries = Itinerary.all
  end

  def show
  end

  def new
    @itinerary = Itinerary.new
    @trip = current_user.trips.find(params[:trip_id])
  end

  def create
    @itinerary = Itinerary.new(trip_params)
    @trip = current_user.trips.find(params[:trip_id])
    if @itinerary.save
      redirect_to user_trip_itinerary_path(current_user, @itinerary.trip, @itinerary)
    else
      Rails.logger.debug(@trip.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:date, :comments)
  end
end
