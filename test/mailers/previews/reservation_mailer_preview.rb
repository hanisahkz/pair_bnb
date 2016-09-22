# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def booking_email
    #byebug
    ReservationMailer.booking_email(Reservation.last.user, Reservation.last.listing.user, Reservation.last.id)
  end
end
