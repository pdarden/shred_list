class PicturesController < ApplicationController
  before_filter :picturable
  def new
    @picture = picturable.pictures.new
  end

  def create
    @picture = picturable.pictures.new(picture_params)
    if @picture.save
      if @picture.picturable_type == 'Equipment'
      redirect_to listing_equipment_path(@picturable.listing, @picturable),
        flash: { success: "You added a picture!" }
      else
        redirect_to listing_path(@picturable.listing),
          flash: { success: "You added a picture!" }
      end
    else
      render :new
    end
  end

  def destroy
    @picture = @picturable.pictures.find(params[:id])
    @picture.destroy
    if @picture.picturable_type == 'Equipment'
      redirect_to listing_equipment_path(@picturable.listing, @picturable),
        notice: "Picture was successfully deleted."
    else
      redirect_to listing_path(@picturable.listing),
        notice: "Picture was successfully deleted."
    end
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

