class ApplicationController < ActionController::Base
  require 'fileutils'

  protect_from_forgery with: :exception



  def self.find_media_working_directory(medium_id)
    media_working_directory = "public/working_directory/" + medium_id.to_s + "/"
    return media_working_directory
  end

  def self.find_media_in_tmp_directory
    media_in_tmp_directory = "public/in_directory/tmp/"
    return media_in_tmp_directory
  end

  def self.find_workflow_in_directory(workflow_id)
    @workflow = Workflow.find(workflow_id)
    workflow_in_directory = "public/in_directory/" + @workflow.in_folder + "/"
    return workflow_in_directory
  end

  def self.find_workflow_out_directory(workflow_id)
    @workflow = Workflow.find(workflow_id)
    workflow_out_directory = "public/out_directory/" + @workflow.out_folder + "/"
    return workflow_out_directory
  end

  def self.create_media_working_directory(medium_id)
    FileUtils.mkdir_p('public/working_directory/' + medium_id)
  end

  def self.copy_media_to_working_directory(medium_id, file_name)
    @medium = Medium.find(medium_id)
    media_working_directory = ApplicationController.find_media_working_directory(medium_id)
    media_in_tmp_directory = ApplicationController.find_media_in_tmp_directory
    file_ext = File.extname(file_name)
    FileUtils.cp(media_in_tmp_directory + file_name, media_working_directory + 'IN_' + medium_id + file_ext)
  end

  def self.copy_media_to_out_directory(medium_id)
    @medium = Medium.find(medium_id)
    media_working_directory = ApplicationController.find_media_working_directory(medium_id)
    media_out_directory = ApplicationController.find_workflow_out_directory(@medium.workflow_id)
    FileUtils.cp(media_working_directory + "OUT_" + medium_id, media_out_directory + @medium.title )
  end

  def self.set_state_to_detected(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'detected')
  end

  def self.set_state_to_copied_to_working_directory(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'copied_to_working_directory')
  end

  def self.set_state_to_metadata_gathered(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'metadata_gathered')
  end

  def self.set_state_to_transcode_started(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'transcode_started')
  end

  def self.set_state_to_transcode_ended(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'transcode_ended')
  end

  def self.set_state_to_copied_to_out_directory(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'copied_to_out_directory')
  end

  def self.set_state_to_ready_for_purge(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'ready_for_purge')
  end

  def self.set_state_to_failed(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: 'failed')
  end

  def self.set_state_to_0(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: '0')
  end

  def self.set_state_to_1(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: '1')
  end

  def self.set_state_to_2(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: '2')
  end

  def self.set_state_to_3(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: '3')
  end

  def self.set_state_to_4(medium_id)
    @medium = Medium.find(medium_id)
    @medium.update(state: '4')
  end

  def self.move_media_to_in_tmp(workflow_id, file_name, medium_id)
    media_in_directory = ApplicationController.find_workflow_in_directory(workflow_id)
    media_in_tmp_directory = ApplicationController.find_media_in_tmp_directory
    tmp_file_name = medium_id + "_" + file_name
    FileUtils.mv(media_in_directory + file_name, media_in_tmp_directory + tmp_file_name)
    return tmp_file_name
  end

  def self.find_files_in_directory(folder)
    files = Dir.entries(folder).select {|f| !File.directory? f}
    return files
  end

  def self.create_new_media_asset(file_name, workflow_id)
    file_basename = File.basename(file_name, ".*")
    @medium = Medium.new(title: file_basename, workflow_id: workflow_id)
    @medium.save
    medium_id = (@medium.id).to_s
    return medium_id
  end

end
