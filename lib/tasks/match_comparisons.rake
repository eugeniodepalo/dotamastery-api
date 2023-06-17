namespace :match_comparisons do
  task all: [:update]

  task update: :environment do
    UpdateMatchComparisonsTask.perform
  end
end
