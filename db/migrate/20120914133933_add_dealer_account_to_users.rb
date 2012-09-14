class AddDealerAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dealer_account, :boolean, :default=>false
  end
end
