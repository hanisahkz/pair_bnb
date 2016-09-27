class ListingsController < ApplicationController
  def index
    if params[:q].blank?   #side note: .blank? is the most accurate because it recoqnizes empty search result as empty and not as a string like .nil? and .empty?
      # byebug
      @listings = Listing.all
    else
      @listings = Listing.search(params[:q])
    end
    # @listings = Listing.where(nil)
    @listings = @listings.price_per_night(params["min"], params["max"]) if (params["min"] || params["max"]).present? 
    # byebug
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
