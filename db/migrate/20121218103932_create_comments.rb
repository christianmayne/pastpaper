class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :document_id
      t.integer :user_id
      t.text :comment
      t.boolean :is_deleted?

      t.timestamps
    end
  end
end
