class CreateLocationCountries < ActiveRecord::Migration
  def change
    create_table :location_countries do |t|
      t.string :name
      t.string :iso_code
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
