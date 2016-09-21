class Listing < ActiveRecord::Base
  # require 'carrierwave/orm/activerecord'

  belongs_to :user

  mount_uploaders :photos, PhotoUploader
end
