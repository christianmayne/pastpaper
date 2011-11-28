class DocumentPhoto < ActiveRecord::Base
	belongs_to :document
	has_attached_file :photo, 
                    :styles => { :small => '80x80#', :thumb => '150x150>' ,:large=> "600X600>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "uploads/:attachment/:id/:style.:extension"
                    #:url  => ":s3_eu_url"
                    #:url => "/images/document_photos/:id/:style/:basename.:extension",
                    #:path => ":rails_root/public/images/document_photos/:id/:style/:basename.:extension"
                    
  
 validates_attachment_size :photo, :less_than => 5.megabytes
 validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/gif', 'image/png']
 validates :photo_file_name ,:presence => true
end
