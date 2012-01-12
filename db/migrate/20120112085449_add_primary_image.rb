class AddPrimaryImage < ActiveRecord::Migration
  def up
     add_column :document_photos, :is_primary,:boolean,:default => false
  end

  def down
    remove_column :document_photos, :is_primary
  end
end
