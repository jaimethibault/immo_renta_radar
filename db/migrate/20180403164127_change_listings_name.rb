class ChangeListingsName < ActiveRecord::Migration[5.0]
  def change
    rename_table :listings, :for_sale_listings
  end
end
