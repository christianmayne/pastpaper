class AddDisplayColumnsToDocumentStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :show_latest_items, :integer
    add_column :statuses, :show_my_items, :integer
    add_column :statuses, :show_featured_items, :integer
    add_column :statuses, :show_search_results, :integer
  end
end
