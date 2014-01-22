class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :offer_id, null: false
      t.integer :sender_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
