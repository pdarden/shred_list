class ChangeIntegerToDecimalInListingAndEquipment < ActiveRecord::Migration
  def up
    change_column :listings, :asking_price, :decimal, precision: 8, scale: 2
    change_column :equipment, :original_price, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :listings, :asking_price, :integer
    change_column :equipment, :original_price, :integer
  end
end
