class AddOrderColumnInEventTypes < ActiveRecord::Migration
  def up
     add_column :event_types, :sort_order,:integer
  end

  def down
    remove_column :event_types, :sort_order
  end
end
