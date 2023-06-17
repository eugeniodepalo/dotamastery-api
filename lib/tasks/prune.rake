namespace :prune do
  task all: [:live_matches, :matches]

  task live_matches: :environment do
    PruneLiveMatchesTask.perform
  end

  task matches: :environment do
    PruneMatchesTask.perform
  end

  task job_statuses: :environment do
    PruneJobStatusesTask.perform
  end
end
