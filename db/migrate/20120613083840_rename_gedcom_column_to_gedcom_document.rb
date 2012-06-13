class RenameGedcomColumnToGedcomDocument < ActiveRecord::Migration
  def change
    rename_column :gedcom_people, :gedcom_id, :gedcom_document_id
  end
end
