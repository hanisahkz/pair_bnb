class TransactionsController < ApplicationController
  before_action :authenticate_user #, [:new, :create]

  def new
    gon.client_token = generate_client_token
    @reservation = current_user.reservations.last
    @total_nights = Reservation.total_nights(@reservation.check_in, @reservation.check_out)
    @total_price = Reservation.total_price(@total_nights, @reservation.listing.price_per_night)
   # @reservation = Reservation.find(params[:id])
   # byebug
  end 

  def create
     # gon.client_token = generate_client_token
     # byebug
     @reservation = current_user.reservations.last
     @total_nights = Reservation.total_nights(@reservation.check_in, @reservation.check_out)
     @total_price = Reservation.total_price(@total_nights, @reservation.listing.price_per_night)
     # byebug
     @result = Braintree::Transaction.sale(
              amount: @total_price,
              payment_method_nonce: params[:payment_method_nonce])
    
    respond_to do |format|
    # byebug
     if @result.success?
        @reservation.update(payment: true)
        
         #byebug
        ReservationMailer.booking_email(@reservation.user.id, @reservation.listing.user.id, @reservation.id).deliver_now 
           #bundle exec sidekiq -q mailers
        format.html { redirect_to root_url, notice: "Congratulations! Your transaction has been successfully!"}
     else
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        gon.client_token = generate_client_token
        format.html { render action: 'new' }
      end
    end
    #   redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
    # else
    #   flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
    #   gon.client_token = generate_client_token
    #   render :new
    # end
  end

  def authenticate_user
    redirect_to sign_in_path if signed_out?
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end

end
