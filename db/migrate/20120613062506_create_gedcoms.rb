class CreateGedcoms < ActiveRecord::Migration
  def change
    create_table :gedcoms do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
