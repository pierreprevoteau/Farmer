class GatherMetadataJob
  require 'fileutils'
  @queue = :metadata

  def self.perform(medium_id)
    puts "**** Performing metadata gathering ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "copied_to_working_directory"
      working_directory = ApplicationController.find_media_working_directory(medium_id)
      files = ApplicationController.find_files_in_directory(working_directory)

      ApplicationController.set_state_to_metadata_started(medium_id)
      files.each do |file|
        mediainfo_cmd = ApplicationController.create_mediainfo_cmd(medium_id, file)
        system mediainfo_cmd
        @metadata = Metadatum.new(medium_id: medium_id, key: "DURATION", value: mediainfo_cmd)
        @metadata.save
      end
      ApplicationController.set_state_to_metadata_gathered(medium_id)

    else
      Resque.enqueue_in(60.seconds, GatherMetadataJob, medium_id)
    end

  end
end
