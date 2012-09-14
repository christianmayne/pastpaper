class AddSortOrderToLocationCountries < ActiveRecord::Migration
  def change
    add_column :location_countries, :sort_order, :integer, :default=>999
  end
end
