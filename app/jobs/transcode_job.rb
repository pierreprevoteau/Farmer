class TranscodeJob
  @queue = :transcode

  require 'fileutils'

  def self.perform(medium_id, transcode_id)
    @medium = Medium.find(medium_id)
    @transcode = Transcode.find(transcode_id)

    puts "----------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "**** Performing " + @transcode.title + " transcode for " + @medium.title
    puts "********************************************************"

    if @medium.state.to_i < 1
      puts "Media not ready for Transcode !"
      puts "----------------------------------------------------------------------------------"
      sleep 10
      Resque.enqueue(TranscodeJob, medium_id, transcode_id)
    elsif @medium.state.to_i == 1
      working_directory = ApplicationController.get_working_directory_path(medium_id)
      infiles = Dir.entries(working_directory).select {|f| !File.directory? f}
      general_option = @transcode.general_option
      infile_option = @transcode.infile_option
      outfile_option = @transcode.outfile_option
      infiles.each do |file|
        transcode_cmd = "ffmpeg " + general_option + " " + infile_option + " -i " + working_directory + file + " " + outfile_option + " " + working_directory + "OUT_" + medium_id
        system transcode_cmd
      end
      @medium.update(state: '2')
      puts "Media transcoded"
      puts "----------------------------------------------------------------------------------"
    else
      puts "Media already transcoded"
      puts "----------------------------------------------------------------------------------"
    end
  end
end
