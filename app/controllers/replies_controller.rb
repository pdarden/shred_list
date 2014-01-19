class RepliesController < ApplicationController
  def create
    @reply = offer.replies.new(reply_params)
    @reply.sender = current_user

    if @reply.save
      redirect_to listing_path(listing),
        flash: { success: "Your reply was posted!" }
    end
  end

  def destroy
    Reply.find(params[:id]).destroy
    redirect_to listing_path(listing),
      flash: { success: "You reply was deleted." }
  end

  private
  def listing
    @listing ||= Listing.find(offer.listing_id)
  end

  def offer
    @offer = Offer.find(params[:offer_id])
  end

  def reply_params
    params.require(:reply).permit(:body, :sender_id, :offer_id)
  end
end
