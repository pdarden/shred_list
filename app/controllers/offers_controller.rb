class OffersController < ApplicationController
  def index
    @offers = Offer.where(filter)
  end

  def create
    @offer = listing.offers.new(offer_params)
    @offer.user = current_user

    if @offer.save
      redirect_to listing_path(@listing),
        flash: { success: "Your offer was posted!" }
    else
      render :new
    end
  end

  def destroy
    Offer.find(params[:id]).destroy
    redirect_to listing_path(@listing)
  end

  private
  def listing
    @listing ||= Listing.find(params[:listing_id])
  end

  def offer_params
    params.require(:offer).permit(:description, :private_message, :user_id, :listing_id)
  end

  def filter
    if params[:user_id]
      { user_id: params[:user_id] }
    else
      {}
    end
  end
end

