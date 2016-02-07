class PagesController < ApplicationController
  def dev
    medium_id = "my medium"
    transcode_id = "my transcode"
    Resque.enqueue(TranscodeJob, medium_id, transcode_id)
  end
end
