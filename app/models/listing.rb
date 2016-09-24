class Listing < ActiveRecord::Base
  # require 'carrierwave/orm/activerecord'
  has_many :reservations, :dependent => :destroy
  belongs_to :user
  scope :price_per_night, -> (min_price) {where price_per_night: min_price}
  mount_uploaders :photos, PhotoUploader
end
