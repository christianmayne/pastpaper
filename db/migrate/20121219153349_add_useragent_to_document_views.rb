class AddUseragentToDocumentViews < ActiveRecord::Migration
  def change
    add_column :document_views, :useragent, :string
  end
end
