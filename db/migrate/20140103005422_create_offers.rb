class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :user_id, null: false
      t.integer :listing_id, null: false
      t.text :description, null: false
      t.boolean :private_message, default: false

      t.timestamps
    end
  end
end
