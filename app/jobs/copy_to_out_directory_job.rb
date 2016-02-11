class CopyToOutDirectoryJob
  require 'fileutils'
  @queue = :copy

  def self.perform(medium_id)
    puts "**** Performing copy to out_directory ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "transcode_ended"
      ApplicationController.copy_media_to_out_directory(medium_id)
      ApplicationController.set_state_to_copied_to_out_directory(medium_id)
    else
      Resque.enqueue_in(60.seconds, CopyToOutDirectoryJob, medium_id)
    end
  end
end
