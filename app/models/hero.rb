class Hero < ApplicationRecord
  include Importable
  has_many :player_participations, dependent: :nullify
end
