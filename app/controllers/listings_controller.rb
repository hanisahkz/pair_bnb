class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to @listing 
    else
      render 'edit'
    end
  end 

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to listings_path
  end 

  def show
    # byebug
    @listing = Listing.find(params[:id])
    @reservation = @listing.reservations.build
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
    params.require(:listing).permit(:title, :description, :price_per_night, :location, :room_type, :guest_capacity, {photos:[]})
  end
end
