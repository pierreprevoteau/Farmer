class TranscodeJob
  @queue = :transcode

  require 'fileutils'

  def self.perform(medium_id, transcode_id)
    @medium = Medium.find(medium_id)
    @transcode = Transcode.find(transcode_id)

    puts "----------------------------------------------------------------"
    puts "Performing " + @transcode.title + " transcode for " + @medium.title
    puts "----------------------------------------------------------------"

    tmp_directory = "public/tmp/" + medium_id + "/"
    files = Dir.entries(tmp_directory).select {|f| !File.directory? f}
    transcode_cmd = "ffmpeg -i " + tmp_directory + file + " " + @transcode.outfile_option + " " + tmp_directory + "FARM_" + medium_id + ".mp4"

    files.each do |file|
      system transcode_cmd
    end
  end
end
