class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :equipment_id, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
