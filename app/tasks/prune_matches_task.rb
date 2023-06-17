class PruneMatchesTask
  include Task

  def perform
    Match.with_expired_replay.destroy_all
  end
end
