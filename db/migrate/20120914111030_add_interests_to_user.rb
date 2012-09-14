class AddInterestsToUser < ActiveRecord::Migration
  def change
    add_column :users, :interest_familyhistory, :boolean, :default => false
    add_column :users, :interest_localhistory, :boolean, :default => false
    add_column :users, :interest_oldbooks, :boolean, :default => false
    add_column :users, :interest_olddocuments, :boolean, :default => false
    add_column :users, :interest_oldnewspapers, :boolean, :default => false
    add_column :users, :interest_oldphotos, :boolean, :default => false
    add_column :users, :interest_oldpostcards, :boolean, :default => false
    add_column :users, :interest_other, :boolean, :default => false
    add_column :users, :interest_other_text, :string
  end
end
