class AddTermsAcceptedToUser < ActiveRecord::Migration
  def change
    add_column :users, :terms_accepted, :boolean, :default=>false
  end
end
