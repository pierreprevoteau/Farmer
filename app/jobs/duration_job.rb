class DurationJob < ActiveJob::Base
  require 'fileutils'

  queue_as :default

  def perform(medium_id)

    puts "----------------------------------------------------------------"
    puts "Performing duration : " + medium_id
    puts "----------------------------------------------------------------"

    tmp_directory = ApplicationController.get_tmp_path(medium_id)

    files = Dir.entries(tmp_directory).select {|f| !File.directory? f}

    files.each do |file|
        filename = tmp_directory + file
        mediainfo_cmd = `mediainfo --Inform='Video;%Duration/String3%' #{filename}`

        @technicals = Technical.new(medium_id: medium_id, key: "DURATION", value: mediainfo_cmd)
        @technicals.save
    end

  end
end



-----------TODO-----------
