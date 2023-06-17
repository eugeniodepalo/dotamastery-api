namespace :sync do
  task all: [:heroes, :live_matches, :matches]

  task heroes: :environment do
    SyncHeroesTask.perform
  end

  task live_matches: :environment do
    SyncLiveMatchesTask.perform
  end

  task matches: :environment do
    SyncMatchesTask.perform
  end
end
