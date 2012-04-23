class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.integer :person_id
      t.integer :event_type_id
      t.integer :location_id
      t.date :fact_date
      t.string :date_modifier
      t.integer :fact_year
      t.integer :fact_month
      t.integer :fact_day

      t.timestamps
    end
  end
end
