class AddFormControlsToSitesController < ActiveRecord::Migration
  def change
    add_column :site_controllers, :popover_enabled, :boolean, :default=>false
    add_column :site_controllers, :popover_heading, :string
    add_column :site_controllers, :popover_mailinglist_form, :boolean, :default=>true
    add_column :site_controllers, :popover_login_form, :boolean, :default=>true
  end
end
