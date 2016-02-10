class CopyToWorkingDirectoryJob
  require 'fileutils'
  @queue = :copy

  def self.perform(file, medium_id)

    puts "--------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "****   Performing copy to Working_directory         ****"
    puts "********************************************************"

    @medium = Medium.find(medium_id)
    
    if @medium.state.to_i == 0
      puts "Processing"
      ApplicationController.create_media_working_directory(medium_id)
      ApplicationController.copy_media_to_working_directory(medium_id, file)
      ApplicationController.set_state_to_1(medium_id)
    else
      puts "Already done"
    end

    puts "--------------------------------------------------------------------------------"
  end
end
