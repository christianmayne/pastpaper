class CreateSiteControllers < ActiveRecord::Migration
  def change
    create_table :site_controllers do |t|
      t.integer :site_status_id

      t.timestamps
    end
  end
end
