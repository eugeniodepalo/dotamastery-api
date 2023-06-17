class MatchSerializer < ApplicationSerializer
  attributes :started_at, :average_mmr, :winner, :dotabuff_url, :original_id
  has_many :player_participations
  has_many :match_comparisons
end
