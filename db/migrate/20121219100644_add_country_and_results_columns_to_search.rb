class AddCountryAndResultsColumnsToSearch < ActiveRecord::Migration
  def change
  	add_column :searches, :country, :string, :after=>:country_id
  	add_column :searches, :results, :integer, :after=>:country
  end
end
