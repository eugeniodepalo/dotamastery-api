class PlayerParticipation < ApplicationRecord
  SIDES = %w(radiant dire)
  LANES = %w(safelane middle offlane jungle enemy_jungle roaming)
  ROLES = %w(core support)

  belongs_to :match, validate: true, autosave: true
  belongs_to :player, validate: true, optional: true, autosave: true
  belongs_to :hero, validate: true, autosave: true
  validates :side, :slot, presence: true
  validates :side, inclusion: { in: SIDES, allow_nil: true }
  validates :lane, inclusion: { in: LANES, allow_nil: true }
  validates :role, inclusion: { in: ROLES, allow_nil: true }
  validates :lane, :role, presence: true, if: ->(p) { p.match.try(:top?) }
end
