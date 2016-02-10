class PagesController < ApplicationController
  def dev
  end

  def overview
    @pending = Medium.all.where(state: ["0", "1"]).order(id: :desc)

    @workers = Resque.workers

    workings = Resque.working
    jobs = workings.collect {|w| w.job }
    worker_jobs = workings.zip(jobs)
    @worker_jobs = worker_jobs.reject { |w, j| w.idle? }

    @completed = Medium.all.where(state: ["2", "3"]).order(id: :desc)
  end
end
