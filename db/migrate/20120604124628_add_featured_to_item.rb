class AddFeaturedToItem < ActiveRecord::Migration
  def change
    add_column :documents, :is_featured, :boolean, :default=>false
  end
end
