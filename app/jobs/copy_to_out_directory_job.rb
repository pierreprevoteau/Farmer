class CopyToOutDirectoryJob
  require 'fileutils'
  @queue = :copy

  def self.perform(medium_id)

    puts "--------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "****   Performing copy to out_directory             ****"
    puts "********************************************************"

    @medium = Medium.find(medium_id)
    
    if @medium.state.to_i < 2
      puts "Not Ready"
      Resque.enqueue_in(30.seconds, CopyToOutDirectoryJob, medium_id)
    elsif @medium.state.to_i == 2
      puts "Processing"
      ApplicationController.copy_media_to_out_directory(medium_id)
      ApplicationController.set_state_to_3(medium_id)
    else
      puts "Already done"
    end

    puts "--------------------------------------------------------------------------------"
  end
end
