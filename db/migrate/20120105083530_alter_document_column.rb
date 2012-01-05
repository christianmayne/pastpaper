class AlterDocumentColumn < ActiveRecord::Migration
  def up
    add_column :documents, :is_deleted,:boolean,:default => false
    remove_column :documents, :is_hidden
  end

  def down
    rename_column :documents, :is_deleted,:is_hidden
  end
end
