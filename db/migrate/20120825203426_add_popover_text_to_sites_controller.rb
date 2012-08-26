class AddPopoverTextToSitesController < ActiveRecord::Migration
  def change
    add_column :site_controllers, :popover_message, :text
  end
end
