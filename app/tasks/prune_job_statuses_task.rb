class PruneJobStatusesTask
  include Task

  def perform
    JobStatus.where('created_at < ?', 30.minutes.ago).destroy_all
  end
end
