namespace :dotabuff do
  task all: [:check]

  task check: :environment do
    match_id = Match.top.last.try(:original_id) || '2749704347'
    players = Dotabuff.client.find_players(match_id)
    raise "Dotabuff scraping failed for match: #{match_id}" if !players
  end
end
