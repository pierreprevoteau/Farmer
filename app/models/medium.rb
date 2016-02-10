class Medium < ActiveRecord::Base
  has_many :metadatum
  belongs_to :workflow
end
