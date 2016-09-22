class ReservationMailer < ApplicationMailer

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @url = "http://localhost:3000/reservations/#{reservation_id}"
    mail(to: @host.email, subject: "Booking Received")
  end
end
