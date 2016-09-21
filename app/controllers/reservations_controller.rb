class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    # byebug
    @reservation = current_user.reservations.build(reservation_params)
    # @reservation.listing_id = @listing.id
    @reservation.check_in = DateTime.strptime(params[:daterange].split[0], "%m/%d/%Y")
    @reservation.check_out = DateTime.strptime(params[:daterange].split[-1], "%m/%d/%Y")
    @reservation.save
    redirect_to @reservation
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest, :room_type, :listing_id)
  end
end
