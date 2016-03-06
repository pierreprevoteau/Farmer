class PurgeJob
  require 'fileutils'
  @queue = :purge

  def self.perform
    puts "**** Performing purge ****"

    @media_in_db = Medium.all.where(state: "copied_to_out_directory").where("updated_at <= :date", date: Time.now.yesterday.beginning_of_day)
    @media_in_db.each do |medium|
      ApplicationController.set_state_to_ready_for_purge(medium.id)
    end

    @media_in_storage = Medium.all.where(state: "ready_for_purge")
    @media_in_storage.each do |clip|
      files = Dir.glob("public/in_directory/tmp/#{clip.id}_*.*")
      files.each do |file|
        File.delete(file)
      end

      clips_path = ApplicationController.find_media_working_directory(clip.id)
      FileUtils.rm_rf(clips_path)
      clip.destroy
    end

  end
end
