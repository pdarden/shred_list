class ListingsController < ApplicationController
  helper_method :listings

  def index
    @q = Listing.search(params[:q])
    @listings = @q.result
      .order('created_at DESC')
      .where(filter)
      .page(params[:page])
      .per(9)

  end

  def search
    index
    render :index
  end

  def show
    @listing = Listing.find(params[:id])
    @offer = Offer.new
    @offers = @listing.offers
    @picture = Picture.new
    @equipments = @listing.equipment.map { |e| e if e.pictures.present? }
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
        flash: { success: "Your Shred Listing was posted!" }
    else
      render :new
    end
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to listing_path(@listing),
        falsh: { success: "Shred Listing was updated!" }
    else
      render :edit
    end
  end

  def destroy
    Listing.find(params[:id]).destroy
    redirect_to new_listing_path,
      notice: "Listing was successfully deleted."
  end

  private
  def listings
    @listings ||= Listing.all
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :trade, :state_id, :price_in_dollars, :asking_items)
  end

  def filter
    if params[:user_id]
      { user_id: User.where(username: params[:user_id]) }
    else
      {}
    end
  end
end

