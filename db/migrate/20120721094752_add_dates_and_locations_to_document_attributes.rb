class AddDatesAndLocationsToDocumentAttributes < ActiveRecord::Migration
  def up
    add_column("attribute_documents","date_modifier","string")
    add_column("attribute_documents","attribute_year","integer")
    add_column("attribute_documents","attribute_month","integer")
    add_column("attribute_documents","attribute_day","integer")
    add_column("attribute_documents","attribute_location", "string")
    
  end

  def down
    remove_column("attribute_documents","date_modifier")
    remove_column("attribute_documents","attribute_year")
    remove_column("attribute_documents","attribute_month")
    remove_column("attribute_documents","attribute_day")
    remove_column("attribute_docuemnts","attribute_location")
  end
end
