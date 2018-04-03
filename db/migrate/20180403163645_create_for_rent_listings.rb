class CreateForRentListings < ActiveRecord::Migration[5.0]
  def change
    create_table :for_rent_listings do |t|
      t.string :seloger_id
      t.float :surface
      t.float :rent_price
      t.string :city
      t.integer :cp

      t.timestamps
    end
  end
end
