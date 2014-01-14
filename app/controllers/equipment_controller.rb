class EquipmentController < ApplicationController
  before_filter :listing, :authenticate_user!

  def new
    @equipment = listing.equipment.new
  end

  def show
    @equipment = listing.equipment.find(params[:id])
    @picture = @equipment.pictures.new
  end

  def edit
    @equipment = listing.equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])

    if @equipment.update(equipment_params)
      redirect_to listing,
        flash: { success: "This equipment need at least a picturefor it to go live." }
    else
      render :edit
    end
  end

  def create
    @equipment = listing.equipment.new(equipment_params)

    if @equipment.save
      redirect_to listing_equipment_path(@listing, @equipment),
        flash: { success: "You added an equipment!" }
    else
      render :new
    end
  end

  def destroy
    listing.equipment.find(params[:id]).destroy
    redirect_to listing,
      notice: "Equipment was successfully deleted."
  end

  private
  def listing
    @listing ||= Listing.find(params[:listing_id])
  end

  def equipment_params
    params.require(:equipment).permit(:brand_id, :category_id, :riding_style_id, :price_in_dollars)
  end
end

