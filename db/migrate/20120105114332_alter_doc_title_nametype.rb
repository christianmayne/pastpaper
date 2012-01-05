class AlterDocTitleNametype < ActiveRecord::Migration
  def up
    change_column("documents","title","text")
   
  end

  def down
    change_column("documents","title","string")
    
  end
end
