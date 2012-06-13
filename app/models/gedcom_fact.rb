class GedcomFact < ActiveRecord::Base
  belongs_to :gedcom_person

  attr_accessor :date
end
