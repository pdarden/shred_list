class EquipmentController < ApplicationController
  before_filter :load_equipmentable

  def index
    @equipment = @equipmentable.equipment
  end

  def new
    @equipment = @equipmentable.equipment.new
  end

  def show
    @equipment = @equipmentable.equipment.find(params[:id])
    @picture = Picture.new
    @pictures = @equipment.pictures
  end

  def edit
    @equipment = @equipmentable.equipment.find(params[:id])
  end

  def update
    @equipment = @equipmentable.equipment.find(equipment_params)

    if @equipment.update(equipment_params)
      redirect_to @equipmentable,
        flash: { success: "Updated equipment successfully!" }
    else
      render :edit
    end
  end

  def create
    @equipment = @equipmentable.equipment.new(equipment_params)

    if @equipment.save
      redirect_to listing_equipment_path(@equipmentable, @equipment),
        flash: { success: "You added an equipment!" }
    else
      render :new
    end
  end

  def destroy
    @equipmentable.equipment.find(params[:id]).destroy
    redirect_to @equipmentable,
      notice: "Equipment was successfully deleted."
  end

  private
  def load_equipmentable
    resource, id = request.path.split('/')[1, 2]
    @equipmentable = resource.singularize.classify.constantize.find(id)
  end

  def equipment_params
    params.require(:equipment).permit(:brand_id, :category_id, :riding_style_id, :original_price)
  end
end
