class TripsController < ApplicationController
  before_action :set_trip, only: %i[show update edit destroy]

  def index
    @trips = current_user.trips
  end

  def show
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      redirect_to user_trip_path(@trip.user, @trip)
    else
      Rails.logger.debug(@trip.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to user_trip_path(current_user, @trip)
    else
      flash.now[:alert] = "trip update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to user_trips_path(current_user), status: :see_other
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :country, :start, :end)
  end
end
