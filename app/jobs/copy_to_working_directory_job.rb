class CopyToWorkingDirectoryJob
  require 'fileutils'
  @queue = :copy

  def self.perform(file, medium_id)
    puts "**** Performing copy to Working_directory ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "detected"
      ApplicationController.create_media_working_directory(medium_id)
      ApplicationController.copy_media_to_working_directory(medium_id, file)
      ApplicationController.set_state_to_copied_to_working_directory(medium_id)
    else
      Resque.enqueue_in(60.seconds, CopyToWorkingDirectoryJob, file, medium_id)
    end
    
  end
end
