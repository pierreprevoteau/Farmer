class ThumbJob < ActiveJob::Base

  require 'fileutils'

  queue_as :default

  def perform(medium_id)
    puts "----------------------------------------------------------------"
    puts "Performing thumb : " + medium_id
    puts "----------------------------------------------------------------"
    tmp_directory = "public/TMP/" + medium_id + "/"
    files = Dir.entries(tmp_directory).select {|f| !File.directory? f}

    files.each do |file|
        transcode_cmd = "ffmpeg -i " + tmp_directory + file + " -ss 00:00:01.000 -vframes 1 " + tmp_directory + "THUMB_" + medium_id + ".png"
        system transcode_cmd
    end
  end
end



-----------TODO-----------
