class DetectJob
  require 'fileutils'
  @queue = :detect

  def self.perform
    puts "--------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "****          Performing detection                  ****"
    puts "********************************************************"

    @workflows = Workflow.all.where(active: true)
    @workflows.each do |workflow|

      workflow_in_directory = ApplicationController.find_workflow_in_directory(workflow.id)
      files = ApplicationController.find_files_in_directory(workflow_in_directory)

      files.each do |file|

        puts workflow_in_directory + "-->" + file

        medium_id = ApplicationController.create_new_media_asset(file, workflow.id)
        ApplicationController.move_media_to_in_progress(workflow.id, file)
        ApplicationController.set_state_to_0(medium_id)
        ApplicationController.create_media_working_directory(medium_id)
        ApplicationController.copy_media_to_working_directory(medium_id, file)
        ApplicationController.move_media_to_done(workflow.id, file)
        ApplicationController.set_state_to_1(medium_id)

        Resque.enqueue(TranscodeJob, medium_id, workflow.transcode_id)
      end
    end

    puts "--------------------------------------------------------------------------------"
  end
end
