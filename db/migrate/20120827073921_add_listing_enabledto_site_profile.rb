class AddListingEnabledtoSiteProfile < ActiveRecord::Migration
  def up
    add_column :site_profiles, :listing_enabled, :boolean, :default => true
  end

  def down
    remove_column :site_profiles, :listing_enabled
  end
end
