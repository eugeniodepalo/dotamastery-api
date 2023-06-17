class MatchComparison < ApplicationRecord
  COMPARED_ATTRIBUTES = [:lane, :role]

  belongs_to :match
  belongs_to :other_match, class_name: 'Match'

  def self.for(match)
    comparisons = Match.top
      .where.not(original_id: match.original_id)
      .includes(:player_participations)
      .references(:player_participations)
      .map { |m| new(match: match, other_match: m) }
      .select(&:relevant?)

    comparisons.each(&:set_similarity)
    comparisons.select(&:similar?).sort_by(&:similarity).reverse.take(5)
  end

  def set_similarity
    self.similarity = compute_similarity
  end

  def relevant?
    match_user_participation &&
    other_match_user_participation &&
    other_match_user_participation.side == other_match.winner
  end

  def similar?
    similarity > 0.1
  end

  private

  def compute_similarity
    similarity = 0

    match.player_participations.each do |match_participation|
      other_match_participation = other_match.player_participations.find do |other_match_participation|
        other_match_participation.hero_id == match_participation.hero_id &&
        normalized_side_for(other_match_participation.side) == match_participation.side
      end

      if other_match_participation
        similarity += 1

        similarity += COMPARED_ATTRIBUTES.count do |attr|
          !match_participation.__send__(attr) ||
          match_participation.__send__(attr) == other_match_participation.__send__(attr)
        end
      end
    end

    similarity.to_f / ((match.player_participations.size) * (1 + COMPARED_ATTRIBUTES.size))
  end

  def match_user_participation
    @match_user_participation ||= match.player_participations.find do |match_participation|
      match_participation.player.original_id == match.user.original_id
    end
  end

  def other_match_user_participation
    @other_match_user_participation ||= other_match.player_participations.find do |other_match_participation|
      other_match_participation.hero_id == match_user_participation.hero_id
    end
  end

  def normalized_side_for(side)
    if match_user_participation.side == other_match_user_participation.side
      side
    else
      side == 'radiant' ? 'dire' : 'radiant'
    end
  end
end
