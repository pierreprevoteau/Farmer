class PurgeJob
  require 'fileutils'
  @queue = :purge

  def self.perform
    puts "**** Performing purge ****"

      # TODO #
      sleep 30

  end
end
