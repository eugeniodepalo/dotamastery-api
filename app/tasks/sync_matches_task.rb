class SyncMatchesTask
  include Task

  def perform
    LiveMatch.all.each do |live_match|
      failsafe do
        steam_match = SteamMatch.new(live_match.match_id)
        live_match.finish! if steam_match.exists?
        next if !steam_match.data?

        match = steam_match.to_match
        match.average_mmr = live_match.average_mmr
        match.save!
        live_match.destroy
      end
    end
  end
end
