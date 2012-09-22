class DropTagTables < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :documents_tags
  end
end
