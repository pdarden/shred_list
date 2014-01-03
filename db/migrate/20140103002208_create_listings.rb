class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :trade, default: false
      t.integer :state_id
      t.integer :asking_price
      t.text :asking_items

      t.timestamps
    end
  end
end
