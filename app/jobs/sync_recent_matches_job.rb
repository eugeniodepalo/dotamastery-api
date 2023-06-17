class SyncRecentMatchesJob < ApplicationJob
  include UserJob

  LOBBY_TYPES = { normal: 0, ranked: 7 }

  queue_as :default

  def perform(user:)
    api_matches = Dota.api.matches(player_id: user.original_id, min_players: 10) || raise(Failsafe::RetriableError)

    recent_matches = api_matches.reject do |match|
      ![LOBBY_TYPES[:normal], LOBBY_TYPES[:ranked]].include?(match.raw['lobby_type']) ||
      match.starts_at < Match::REPLAY_EXPIRY_TIME.ago
    end

    new_matches = recent_matches.reject { |m| user.matches.map(&:original_id).include?(m.id) }

    new_matches.each do |new_match|
      steam_match = SteamMatch.new(new_match.id)
      raise Failsafe::RetriableError if !steam_match.exists?

      match = steam_match.to_match
      match.user = user
      match.match_comparisons = MatchComparison.for(match)
      match.save!
    end
  end
end
