class AddEquipmentableToEquipment < ActiveRecord::Migration
  def up
    drop_table :equipment
    create_table :equipment do |t|
      t.integer  "brand_id"
      t.integer  "category_id"
      t.integer  "riding_style_id"
      t.integer  "original_price",  null: false
      t.belongs_to :equipmentable, polymorphic: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :equipment, [:equipmentable_id, :equipmentable_type]
  end

  def down
    drop_table :equipment
    create_table :equipment do |t|
      t.integer  "brand_id"
      t.integer  "category_id"
      t.integer  "riding_style_id"
      t.integer  "original_price",  null: false
      t.integer  "offer_id"
      t.integer  "listing_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

end
