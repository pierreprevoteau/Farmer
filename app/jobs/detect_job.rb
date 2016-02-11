class DetectJob
  require 'fileutils'
  @queue = :detect

  def self.perform
    puts "**** Performing detection ****"

    @workflows = Workflow.all.where(active: true)
    @workflows.each do |workflow|

      workflow_in_directory = ApplicationController.find_workflow_in_directory(workflow.id)
      files = ApplicationController.find_files_in_directory(workflow_in_directory)

      files.each do |file|
        medium_id = ApplicationController.create_new_media_asset(file, workflow.id)
        tmp_file_name = ApplicationController.move_media_to_in_tmp(workflow.id, file, medium_id)
        ApplicationController.set_state_to_detected(medium_id)

        Resque.enqueue(CopyToWorkingDirectoryJob, tmp_file_name, medium_id)
        Resque.enqueue(GatherMetadataJob, medium_id)
        Resque.enqueue(TranscodeJob, medium_id)
        Resque.enqueue(CopyToOutDirectoryJob, medium_id)
      end
    end
  end
end
