class CreateRidingStyles < ActiveRecord::Migration
  def change
    create_table :riding_styles do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end
