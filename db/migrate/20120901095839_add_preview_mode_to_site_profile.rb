class AddPreviewModeToSiteProfile < ActiveRecord::Migration

  def up
    add_column :site_profiles, :preview_mode, :boolean, :default => true
  end

  def down
    remove_column :site_profiles, :preview_mode
  end

end
