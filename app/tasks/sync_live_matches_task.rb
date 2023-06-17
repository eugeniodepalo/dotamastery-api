class SyncLiveMatchesTask
  include Task

  RANKED_LOBBY_TYPE = 7
  PARTNERS = 0..3

  def perform
    PARTNERS.inject([]) do |memo, partner|
      memo + (failsafe { get_top_live_game(partner) } || [])
    end.each do |api_live_match|
      failsafe do
        next if api_live_match['lobby_type'] != RANKED_LOBBY_TYPE

        realtime_stats = get_realtime_stats(api_live_match)
        next if !realtime_stats
        
        LiveMatch.find_or_create_by!(original_id: api_live_match['lobby_id']) do |live_match|
          live_match.average_mmr = api_live_match['average_mmr']
          live_match.match_id = realtime_stats['matchid']
        end
      end
    end
  end

  private

  def get_top_live_game(partner)
    Dota.api.get('IDOTA2Match_570', 'GetTopLiveGame', partner: partner)['game_list'] || raise(Failsafe::RetriableError)
  end

  def get_realtime_stats(api_live_match)
    Dota.api.get('IDOTA2MatchStats_570', 'GetRealtimeStats', server_steam_id: api_live_match['server_steam_id'])['match']
  end
end
