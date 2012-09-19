class AddCountryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location_country_id, :integer
  end
end
