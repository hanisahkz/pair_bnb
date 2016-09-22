class ReservationMailer < ApplicationMailer

  def booking_email(customer_id, host_id, reservation_id)
    @customer = User.find(customer_id)
    @host = User.find(host_id)
    @url = "http://localhost:3000/reservations/#{reservation_id}"
    mail(to: @host.email, subject: "Booking Received")
  end
end
