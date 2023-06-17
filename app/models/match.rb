class Match < ApplicationRecord
  REPLAY_EXPIRY_TIME = 1.week

  belongs_to :user, optional: true
  has_many :player_participations, dependent: :destroy
  has_many :match_comparisons, dependent: :destroy
  has_many :other_match_comparisons, dependent: :destroy, foreign_key: 'other_match_id', class_name: 'MatchComparison'
  validates :started_at, :winner, presence: true
  validates :average_mmr, presence: true, if: :top?
  scope :top, -> { where(user: nil) }
  scope :with_expired_replay, -> { where('started_at < ?', REPLAY_EXPIRY_TIME.ago) }

  def top?
    !user_id?
  end

  def dotabuff_url
    "http://www.dotabuff.com/matches/#{original_id}"
  end
end
