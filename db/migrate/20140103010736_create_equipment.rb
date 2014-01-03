class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :brand_id
      t.integer :category_id
      t.integer :riding_style_id
      t.integer :original_price, null: false
      t.integer :offer_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
