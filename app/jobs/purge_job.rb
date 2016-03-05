class PurgeJob
  require 'fileutils'
  @queue = :purge

  def self.perform
    puts "**** Performing purge ****"

    @media = Medium.all.where(state: "copied_to_out_directory").where("updated_at <= :date", date: Time.now.yesterday.beginning_of_day)

    @media.each do |medium|
      ApplicationController.set_state_to_ready_for_purge(medium.id)
      medium_path = ApplicationController.find_media_working_directory(medium.id)
      FileUtils.rm_rf(medium_path)
      medium.destroy
    end

  end
end
