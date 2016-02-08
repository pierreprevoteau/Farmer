class PagesController < ApplicationController
  def dev
    Resque.enqueue(DetectJob)
    medium_id = "1"
    transcode_id = "1"
    Resque.enqueue(TranscodeJob, medium_id, transcode_id)
  end
end
