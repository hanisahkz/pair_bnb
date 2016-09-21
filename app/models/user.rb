class User < ActiveRecord::Base
  include Clearance::User
  include UsersHelper

  has_many :listings, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :authentications, :dependent => :destroy



  def self.create_with_auth_and_hash(authentication,auth_hash)
  
    create! do |u|
      u.first_name = auth_hash["info"]["name"].split[0]
      u.last_name = auth_hash["info"]["name"].split[-1]
      u.email = auth_hash["info"]["email"]
      u.password = SecureRandom.base64(8)
      u.authentications << authentication
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

end
