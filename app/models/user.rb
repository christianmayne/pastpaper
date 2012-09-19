class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :first_name, :last_name, :email,:username, :password, :password_confirmation
  validates :email, :presence => true 
  validates :first_name, :presence => true
  validates :last_name, :presence => true
 
  validates :password, :confirmation => true,
                       :length => { :within => 6..20 },
                       :presence => true,
                       :if => :password_required?
 
  validates :email, :uniqueness => true
  validates :username ,:presence=>true, :uniqueness =>true ,:length=>{:within=>6..30}
  validates :email,                        
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  

  
  authenticates_with_sorcery!
  has_many :documents
  has_many :gedcom_documents, :dependent => :destroy

  belongs_to :location_country
 
def name
      [self.first_name, self.last_name].delete_if{|ad_elem| ad_elem.blank?}.join(' ')

  end
  
  def is_document_owner(document_user_id)
    self.id == document_user_id
  end
  
  
   def password_required?

      crypted_password.blank? || password.present? 
      
    end
    
    
    
  def dob_date_less
    if !date_of_birth.blank? and date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in future")
    end
  end
  
  
  def dob_date_greater
    if !date_of_birth.blank? and date_of_birth < Date.today - 100.years
      errors.add(:date_of_birth, "can't be more than 100 years")
    end
  end
  
  def address
    [self.address1, self.address2, self.city, self.county, self.post_code,self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
  end

  
end
