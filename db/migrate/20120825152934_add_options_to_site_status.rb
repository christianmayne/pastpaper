class AddOptionsToSiteStatus < ActiveRecord::Migration
  def change
    add_column :site_statuses, :login_form, :boolean
    add_column :site_statuses, :mailing_list_form, :boolean

  end
end
