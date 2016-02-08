class DetectJob
  @queue = :detect

  require 'fileutils'

  def self.perform
    @workflows = Workflow.all.where(active: true)

    puts "----------------------------------------------------------------------------------"
    puts "********************************************************"
    puts "**** Performing detection"
    puts "********************************************************"

    @workflows.each do |workflow|
      in_directory = ApplicationController.get_in_directory_path(workflow.id)
      working_directory = ApplicationController.get_working_directory_path(workflow.id)

      puts ">" + in_directory

      files = Dir.entries(in_directory).select {|f| !File.directory? f}
      files.delete(".DS_Store")
      files.delete("DONE")
      files.delete("FAILED")

      files.each do |file|

        puts "-->" + file

        file_basename = File.basename(file, ".*")

        @medium = Medium.new(title: file_basename, state: '0', workflow_id: workflow.id)
        @medium.save

        medium_id = (@medium.id).to_s
        

      end
    end

    puts "----------------------------------------------------------------------------------"
  end
end
