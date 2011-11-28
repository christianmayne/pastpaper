class CreatePersonEvents < ActiveRecord::Migration
  def change
    create_table :person_events do |t|
      t.integer :person_id
      t.integer :event_type_id
      t.date :date_event
      t.string :street1
      t.string :street2
      t.string :city
      t.string :town
      t.string :county
      t.string :country
      t.string :additional_info

      t.timestamps
    end
  end
end
