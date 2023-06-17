class PlayerParticipationSerializer < ApplicationSerializer
  attributes :lane, :side, :slot
  has_one :hero
  has_one :player
end
