class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to @listing
    else
      render template: "listings/new"
    end 
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price_per_night, :location, :room_type, :guest_capacity)
  end
end
