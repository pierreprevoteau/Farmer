class PushToInterplayJob
  require 'fileutils'
  @queue = :push

  def self.perform(medium_id)
    puts "**** Performing push to Interplay ****"

    @medium = Medium.find(medium_id)

    if @medium.state == "transcode_started"
      # TODO #
      sleep 30
    else
      Resque.enqueue_in(10.seconds, PushToInterplayJob, medium_id)
    end
    
  end
end
