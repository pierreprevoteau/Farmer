class TranscodeJob
  require 'fileutils'
  @queue = :transcode

  def self.perform(medium_id)
    puts "**** Performing transcode ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "metadata_gathered"
      working_directory = ApplicationController.find_media_working_directory(medium_id)
      files = ApplicationController.find_files_in_directory(working_directory)

      ApplicationController.set_state_to_transcode_started(medium_id)
      files.each do |file|
        transcode_cmd = ApplicationController.create_transcode_cmd(medium_id, file)
        system transcode_cmd
      end
      ApplicationController.set_state_to_transcode_ended(medium_id)

    else
      Resque.enqueue_in(60.seconds, TranscodeJob, medium_id)
    end
    
  end
end
