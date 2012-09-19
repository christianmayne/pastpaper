class CreateShippingZonePriceMatrices < ActiveRecord::Migration
  def change
    create_table :shipping_zone_price_matrices do |t|
      t.integer :shipping_zone_id
      t.decimal :weight_g
      t.decimal :price

      t.timestamps
    end
  end
end
