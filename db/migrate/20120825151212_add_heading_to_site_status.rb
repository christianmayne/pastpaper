class AddHeadingToSiteStatus < ActiveRecord::Migration
  def change
    add_column :site_statuses, :heading, :string
  end
end
