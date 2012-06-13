class GedcomPerson < ActiveRecord::Base
  belongs_to :gedcom_document
  has_many :gedcom_facts, :dependent => :destroy

  def name=(full_name)
    full_name.gsub!('/', '')
    name_parts = full_name.split(' ')


    if name_parts.size == 1
      @first_name = name_parts[0]
    elsif name_parts.size == 2
      @first_name = name_parts[0]
      @last_name = name_parts[1]
    elsif name_parts.size > 2
      @first_name = name_parts[1]
      @last_name = name_parts[name_parts.size - 1]
      @middle_name = name_parts[1..name_parts.size]
    end

  end
end
