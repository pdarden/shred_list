class AddPicturableToPicture < ActiveRecord::Migration
  def up
    drop_table :pictures

    create_table :pictures do |t|
      t.string :image, null: false
      t.belongs_to :picturable, polymorphic: true

      t.timestamps
    end

    add_index :pictures, [:picturable_id, :picturable_type]

    drop_table :equipment

    create_table :equipment do |t|
      t.integer  "brand_id"
      t.integer  "category_id"
      t.integer  "riding_style_id"
      t.integer  "original_price",  null: false
      t.integer  "offer_id"
      t.integer  "listing_id"

      t.timestamps
    end
  end

  def down
    drop_table :pictures

    create_table :pictures do |t|
      t.integer :equipment_id, null: false
      t.string :image, null: false

      t.timestamps
    end

    drop_table :equipment

    create_table :equipment do |t|
      t.integer  "brand_id"
      t.integer  "category_id"
      t.integer  "riding_style_id"
      t.integer  "original_price",  null: false
      t.belongs_to :equipmentable, polymorphic: true

      t.timestamps
    end

    add_index :equipment, [:equipmentable_id, :equipmentable_type]
  end
end
