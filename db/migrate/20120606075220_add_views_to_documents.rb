class AddViewsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :views, :integer, :default=>0
  end
end