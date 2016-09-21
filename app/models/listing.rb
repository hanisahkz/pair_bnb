class Listing < ActiveRecord::Base
  # require 'carrierwave/orm/activerecord'
  has_many :reservations, :dependent => :destroy
  belongs_to :user

  mount_uploaders :photos, PhotoUploader
end
