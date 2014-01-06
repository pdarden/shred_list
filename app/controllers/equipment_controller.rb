class EquipmentController < ApplicationController
  before_filter :load_equipmentable

  def index
    @equipment = @equipmentable.equipment
  end

  def new
    @equipment = @equipmentable.equipment.new
  end

  def edit
    @equipment = @equipmentable.equipment.find(params[:id])
  end

  def update
    @equipment = @equipmentable.equipment.find(equipment_params)

    if @equipment.update(params[:equipment])
      redirect_to @equipmentable,
        notice: "Updated equipment successfully!"
    else
      render :edit
    end
  end

  def create
    @equipment = @equipmentable.equipment.new(equipment_params)

    if @equipment.save
      redirect_to @equipmentable,
        notice: "You added an equipment!"
    else
      flash.now[:notice] = "There was an issue with your equipment. Please try again."
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
