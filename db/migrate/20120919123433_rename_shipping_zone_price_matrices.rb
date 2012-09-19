class RenameShippingZonePriceMatrices < ActiveRecord::Migration
  def change
    rename_table :shipping_zone_price_matrices, :shipping_zone_prices
  end

end
