class TranscodeJob
  require 'fileutils'
  @queue = :transcode

  def self.perform(medium_id)

    puts "--------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "****              Performing transcode              ****"
    puts "********************************************************"

    @medium = Medium.find(medium_id)
    @workflow = Workflow.find(@medium.workflow_id)
    @transcode = Transcode.find(@workflow.transcode_id)

    if @medium.state.to_i < 1
      puts "Not Ready"
      Resque.enqueue_in(30.seconds, TranscodeJob, medium_id)
    elsif @medium.state.to_i == 1
      puts "Processing"
      working_directory = ApplicationController.find_media_working_directory(medium_id)
      files = ApplicationController.find_files_in_directory(working_directory)
      general_option = @transcode.general_option
      infile_option = @transcode.infile_option
      outfile_option = @transcode.outfile_option

      files.each do |file|
        transcode_cmd = "ffmpeg " + general_option + " " + infile_option + " -i " + working_directory + file + " " + outfile_option + " " + working_directory + "OUT_" + medium_id
        system transcode_cmd
      end
      ApplicationController.set_state_to_2(medium_id)
    else
      puts "Already done"
    end

    puts "--------------------------------------------------------------------------------"
  end
end
