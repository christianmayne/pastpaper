class CreateDocumentFacts < ActiveRecord::Migration
  def change
    create_table :document_facts do |t|
      t.integer :document_id
      t.integer :fact_id

      t.timestamps
    end
  end
end
