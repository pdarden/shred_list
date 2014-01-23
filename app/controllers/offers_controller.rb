class OffersController < ApplicationController
  def index
    @user = User.where(username: params[:user_id]).includes(:offers).first
    @offers = @user.offers
  end

  def create
    @offer = listing.offers.new(offer_params)
    @offer.user = current_user
    @user = @offer.listing.user

    if @offer.save
      OfferNotification.make_offer(@user).deliver
      redirect_to listing_path(listing),
        flash: { success: "Your offer was posted!" }
    end
  end

  def destroy
    Offer.find(params[:id]).destroy
    redirect_to listing_path(listing),
      flash: { success: "Your offer was deleted." }
  end

  private
  def listing
    @listing ||= Listing.find(params[:listing_id])
  end

  def offer_params
    params.require(:offer).permit(:description, :private_message, :user_id, :listing_id,
                                 pictures_attributes: [:image])
  end

  def filter
    if params[:user_id]
      { user_id: params[:user_id] }
    else
      {}
    end
  end
end

