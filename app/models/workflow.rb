class Workflow < ActiveRecord::Base
  belongs_to :transcode
  has_many :medium
end
