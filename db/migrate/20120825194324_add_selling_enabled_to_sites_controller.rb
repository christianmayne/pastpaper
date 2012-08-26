class AddSellingEnabledToSitesController < ActiveRecord::Migration
  def change
    add_column :site_controllers, :selling_enabled, :boolean, :default=>true
  end
end
