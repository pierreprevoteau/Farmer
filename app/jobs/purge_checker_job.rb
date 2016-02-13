class PurgeJob
  require 'fileutils'
  @queue = :purge

  def self.perform
    puts "**** Performing purge check ****"

      # TODO #
      sleep 30

  end
end
