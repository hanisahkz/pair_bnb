class Listing < ActiveRecord::Base
  # require 'carrierwave/orm/activerecord'
  has_many :reservations, :dependent => :destroy
  belongs_to :user
  scope :price_per_night, -> (min, max) { where('price_per_night >= ? AND price_per_night <= ?' , min.to_i, max.to_i) }
  mount_uploaders :photos, PhotoUploader
end
