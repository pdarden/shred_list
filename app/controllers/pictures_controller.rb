class PicturesController < ApplicationController
  before_filter :picturable
  def new
    @picture = picturable.pictures.new
  end

  def create
    @picture = picturable.pictures.new(picture_params)
    if @picture.save
      redirect_to listing_equipment_path(@picturable.listing, @picturable),
        flash: { success: "You added a picture!" }
    else
      render :new
    end
  end

  def destroy
    @picturable.pictures.find(params[:id]).destroy
    redirect_to listing_equipment_path(@picturable.listing, @picturable),
      notice: "Picture was successfully deleted."
  end

  private
  def picturable
    resource, id = request.path.split('/')[1, 2]
    @picturable = resource.singularize.classify.constantize.find(id)
  end

  def picture_params
    params.require(:picture).permit(:equipment_id, :image)
  end
end

