class ListingsController < ApplicationController
  helper_method :listings

  def index
  end

  def show
    @listing = Listing.find(params[:id])
    @equipmentable = @listing
    @equipments = @equipmentable.equipment
    @equipment = Equipment.new
  end

  def new
    @listing = Listing.new
    @equipmentable = @listing
    @equipment = @equipmentable.equipment.build
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = Listing.new(listing_params)

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
      render action: 'edit'
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
