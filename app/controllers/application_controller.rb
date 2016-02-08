class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def self.get_working_directory_path(medium_id)
    working_directory_path = "public/working_directory/" + medium_id.to_s + "/"
    return working_directory_path
  end

  def self.get_in_directory_path(workflow_id)
    @workflow = Workflow.find(workflow_id)
    in_directory_path = "public/in_directory/" + @workflow.in_folder + "/"
    return in_directory_path
  end

  def self.get_out_directory_path(workflow_id)
    @workflow = Workflow.find(workflow_id)
    out_directory_path = "public/out_directory/" + @workflow.out_folder + "/"
    return out_directory_path
  end

end
