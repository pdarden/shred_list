class ListingsController < ApplicationController
  helper_method :listings

  def index
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    if @listing.save
      redirect_to listing_path(@listing),
        notice: "Your Shred Listing was posted!"
    else
      render :new
    end
  end

  def update
    @listing = Lising.new(listing_params)

    if @listing.update(listing_params)
      redirect_to listing_path(@listing),
        notice: "Shred Listing was updated!"
    else
      render :edit
    end
  end

  private
  def listings
    @listings ||= Listing.all
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :trade, :state_id, :asking_price, :asking_items)
  end
end
