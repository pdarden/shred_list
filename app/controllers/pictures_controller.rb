class PicturesController < ApplicationController
  def new
    @equipment = Equipment.find(params[:id])
    @picture = Picture.new
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @equipmentable_id = @equipment.equipmentable_id
    @picture = @equipment.pictures.build(picture_params)
    if @picture.save
      redirect_to listing_equipment_path(@equipmentable_id, @equipment.id)
    else
      render :new
    end
  end

  def destroy
    @picture.find(params[:id]).destroy
  end

  private
  def picture_params
    params.require(:picture).permit(:equipment_id, :image)
  end
end
