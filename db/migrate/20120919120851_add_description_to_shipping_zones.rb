class AddDescriptionToShippingZones < ActiveRecord::Migration
  def change
    add_column :shipping_zones, :description, :text
  end
end
