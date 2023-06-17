class SteamMatch
  def initialize(id)
    @id = id
  end

  def exists?
    !!match.try(:id)
  end

  def data?
    exists? && players_data.present?
  end

  def to_match
    Match.new(
     original_id: id,
     started_at: match.starts_at,
     winner: match.winner.to_s,
     player_participations: player_participations,
     region: (Constants::REGIONS_MAPPING.find { |_, c| c.include?(match.cluster) } || [])[0],
     duration: match.duration
   )
 end

  private

  attr_reader :id

  def match
    @match ||= Dota.api.matches(id)
  end

  def players
    @players ||= match.radiant.players + match.dire.players
  end

  def player_summaries
    @player_summaries ||= Steam::User.summaries(players.map { |p| SteamUtils.steam_id_for(p.id) })
  end

  def players_data
    @players_data ||= Dotabuff.client.find_players(match.id)
  end

  def player_participations
    @player_participations ||= players.map.with_index do |api_player, index|
      side = index > 4 ? 'dire' : 'radiant'

      PlayerParticipation.new(
        player: player_for(api_player),
        hero: Hero.find_or_initialize_by(original_id: api_player.raw['hero_id']),
        lane: players_data.present? ? Constants::LANES_MAPPING[side][players_data[index][:lane]] : nil,
        role: players_data.present? ? players_data[index][:role] : nil,
        side: side,
        slot: api_player.slot
      )
    end
  end

  def player_for(api_player)
    summary = player_summaries.find { |s| s['steamid'].to_i == SteamUtils.steam_id_for(api_player.id) }
    player = Player.find_or_initialize_by(original_id: api_player.id)
    player.assign_attributes(name: summary['personaname']) if summary
    player
  end
end
