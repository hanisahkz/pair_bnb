class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing


  def self.total_nights(check_in, check_out)
    @total_night = (check_out - check_in).to_i 
  end

  def self.total_price(total_nights, price_per_night)
    @total_price = total_nights * price_per_night
  end

end
