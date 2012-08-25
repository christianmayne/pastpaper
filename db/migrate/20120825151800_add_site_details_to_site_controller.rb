class AddSiteDetailsToSiteController < ActiveRecord::Migration
  def change
    add_column :site_controllers, :site_name, :string
    add_column :site_controllers, :site_url, :string
    add_column :site_controllers, :profile_name, :string
  end
end
