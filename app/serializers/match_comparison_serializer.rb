class MatchComparisonSerializer < ApplicationSerializer
  attributes :similarity
  has_one :other_match
end
