class ExportJob < ActiveJob::Base
  require 'fileutils'

  queue_as :default

  def perform(medium_id, workflow_id)

    @medium = Medium.find(medium_id)
    @workflow = Workflow.find(workflow_id)

    puts "----------------------------------------------------------------"
    puts "Performing " + @workflow.kind + " : " + @workflow.title
    puts "----------------------------------------------------------------"

    ApplicationController.get_tmp_path(medium_id)
    ApplicationController.get_stg_path(medium_id)



  end
end


-----------TODO-----------
