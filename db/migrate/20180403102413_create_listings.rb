class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :seloger_id
      t.float :surface
      t.float :price
      t.string :city
      t.integer :cp

      t.timestamps
    end
  end
end
