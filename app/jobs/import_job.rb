class ImportJob < ActiveJob::Base

  require 'fileutils'

  queue_as :default

  def perform(title, kind, storage_folder, db_folder)
    puts "----------------------------------------------------------------"
    puts "Performing " + kind + " : " + title
    puts "----------------------------------------------------------------"

    ingest_directory = 'public/IN/'+ storage_folder + '/'
    video_extensions = [".mp4", ".mxf"]
    audio_extensions = [".mp3", ".wav"]
    files = Dir.entries(ingest_directory).select {|f| !File.directory? f}
    files.delete(".DS_Store")
    files.delete("DONE")
    files.delete("FAILED")

    files.each do |file|
      puts file
      file_extname = File.extname(file)
      file_basename = File.basename(file, ".*")

      if (video_extensions.include? file_extname)
        sort = 1
      elsif (audio_extensions.include? file_extname)
        sort = 2
      else
        sort = 1
      end

      @medium = Medium.new(title: file_basename, sort_id: sort, state_id: '2', created_by: '1', updated_by: '1', tag_id: '1', duration: '00:00:00:00')
      @medium.save

      medium_id = (@medium.id).to_s

      @link = Link.new(folder_id: db_folder, medium_id: medium_id)
      @link.save

      FileUtils.mkdir_p('public/STORAGE/A/1000/' + medium_id)
      FileUtils.mkdir_p('public/TMP/' + medium_id)
      FileUtils.cp(ingest_directory + file, 'public/TMP/' + medium_id + '/SRC_' + medium_id + file_extname)
      FileUtils.mv(ingest_directory + file, ingest_directory + 'DONE/' + file)

      TranscodeJob.perform_later(medium_id, 1)
      FileUtils.mv("public/TMP/" + medium_id + "/LR_" + medium_id + file_extname, "public/STORAGE/A/1000/" + medium_id + "/LR_" + medium_id + file_extname)

      ThumbJob.perform_later(medium_id)
      FileUtils.mv("public/TMP/" + medium_id + "/THUMB_" + medium_id + ".png", "public/STORAGE/A/1000/" + medium_id + "/THUMB_" + medium_id + ".png")
      DurationJob.perform_later(medium_id)
      @medium.update(state_id: '1')
    end
  end
end



-----------TODO-----------
