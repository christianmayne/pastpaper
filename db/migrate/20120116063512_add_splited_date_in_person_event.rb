class AddSplitedDateInPersonEvent < ActiveRecord::Migration
  def up
    add_column("person_events","date_modifier","string")
    add_column("person_events","event_year","integer")
    add_column("person_events","event_month","integer")
    add_column("person_events","event_day","integer")
    
  end

  def down
    remove_column("person_events","date_modifier")
    remove_column("person_events","event_year")
    remove_column("person_events","event_month")
    remove_column("person_events","event_day")
    
  end
end
