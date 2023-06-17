class UpdateMatchComparisonsTask
  include Task

  def perform
    Match.where.not(user: nil).each { |m| m.update!(match_comparisons: MatchComparison.for(m)) }
  end
end
