class PagesController < ApplicationController
  def dev
    Resque.enqueue(DetectJob)
  end
end
