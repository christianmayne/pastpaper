class DocumentFact < ActiveRecord::Base
belongs_to :document
belongs_to :fact
end
