class CreateSiteStatuses < ActiveRecord::Migration
  def change
    create_table :site_statuses do |t|
      t.string :status
      t.string :description
      t.text :message

      t.timestamps
    end
  end
end
