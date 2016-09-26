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
    
    if @reservation.save
      redirect_to @reservation
    else
      render 'new'
    end
    # respond_to do |format|
              # if
        #byebug
        # ReservationMailer.booking_email(@reservation.user.id, @reservation.listing.user.id, @reservation.id).deliver_now 
         #bundle exec sidekiq -q mailers
        # format.html { redirect_to @reservation, notice: "Booking successfully created"}
      # else
        # format.html { render action: 'new' }
      # end
    # end
  end

  def show
    @reservation = Reservation.find(params[:id])

    # byebug
    @total_nights = Reservation.total_nights(@reservation.check_in, @reservation.check_out)
    @total_price = Reservation.total_price(@total_nights, @reservation.listing.price_per_night)

    # render '/transactions/new'

  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guest, :room_type, :listing_id)
  end
end
