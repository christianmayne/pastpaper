class AddSitesToDocumentType < ActiveRecord::Migration
  def change
    add_column :document_types, :paper, :boolean, :default => 1
    add_column :document_types, :stone, :boolean, :default => 1
  end
end
