class RenameGedcomToGedcomDocument < ActiveRecord::Migration
  def change
    rename_table :gedcoms, :gedcom_documents
  end
end
