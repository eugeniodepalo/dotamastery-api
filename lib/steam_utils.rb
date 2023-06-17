module SteamUtils
  OFFSET = 76561197960265728
  
  def self.steam_id_for(player_id)
    player_id + OFFSET
  end

  def self.player_id_for(steam_id)
    steam_id - OFFSET
  end
end
