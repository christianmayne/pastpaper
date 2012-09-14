class RenameUserDealerToIsDealer < ActiveRecord::Migration
  def change
    rename_column :users, :dealer, :is_dealer
  end
end
