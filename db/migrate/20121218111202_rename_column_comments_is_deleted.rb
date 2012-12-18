class RenameColumnCommentsIsDeleted < ActiveRecord::Migration
  def change
  	rename_column :comments, :is_deleted?, :is_deleted
  end

end
