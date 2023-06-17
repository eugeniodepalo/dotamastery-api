class PruneLiveMatchesTask
  include Task

  def perform
    LiveMatch.where('created_at < ?', 1.week.ago).or(
      LiveMatch.finished.where('finished_at < ?', 2.hours.ago)
    ).destroy_all
  end
end
