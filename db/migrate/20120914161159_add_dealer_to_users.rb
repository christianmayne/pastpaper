class AddDealerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealer, :boolean, :default=>false
  end
end
