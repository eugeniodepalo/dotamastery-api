class LiveMatch < ApplicationRecord
  include Importable
  
  scope :finished, -> { where.not(finished_at: nil) }
  validates :match_id, :average_mmr, presence: true

  def finish!
    update!(finished_at: Time.now) if !finished_at
  end
end
