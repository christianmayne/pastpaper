class CreateDocumentsTags < ActiveRecord::Migration
  def up
    create_table :documents_tags, :id => false do |t|
      t.references :document
      t.references :tag
    end
  end

  def down
    droptable :documents_tags
  end
end
