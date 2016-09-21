class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    # byebug
    @reservation = current_user.reservations.build(reservation_params)
    # @reservation.listing_id = @listing.id

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
