class SearchController < ApplicationController

  def search 
    # byebug
    if params[:q].blank?   #side note: .blank? is the most accurate because it recoqnizes empty search result as empty and not as a string like .nil? and .empty?
      # byebug
      @listings = Listing.all 
    else
      @listings = Listing.search(params[:q])
    end
  end

  



end
