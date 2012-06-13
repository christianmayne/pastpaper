class CreateGedcomFacts < ActiveRecord::Migration
  def change
    create_table :gedcom_facts do |t|
      t.integer :gedcom_person_id
      t.string :kind
      t.string :date_modifier
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :location
      t.timestamps
    end
  end
end
