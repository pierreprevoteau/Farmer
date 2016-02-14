class GatherMetadataJob
  require 'fileutils'
  @queue = :metadata

  def self.perform(medium_id)
    puts "**** Performing metadata gathering ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "copied_to_working_directory"
      # TODO #
      ApplicationController.set_state_to_metadata_gathered(medium_id)
    else
      Resque.enqueue_in(60.seconds, GatherMetadataJob, medium_id)
    end
    
  end
end
