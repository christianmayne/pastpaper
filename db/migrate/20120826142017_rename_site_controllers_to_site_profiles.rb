class RenameSiteControllersToSiteProfiles < ActiveRecord::Migration
  def self.up
    rename_table :site_controllers, :site_profiles
  end 

  def self.down
    rename_table :site_profiles, :site_controllers
  end
end
