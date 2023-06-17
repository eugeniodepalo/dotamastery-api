class MatchesController
  class IndexAction
    include Action

    FILTERS = %i(
      filter_by_hero filter_by_side filter_by_lanes filter_by_result filter_by_role filter_by_regions filter_by_duration
    )

    def render
      params.permit([
        :user_id, :hero_id, :side, :include_losses, :role, :duration, :page, :per_page, :sort, :format, :include,
        { lanes: [], regions: [] }
      ])

      {
        json: paginated_matches,
        meta: { total_count: paginated_matches.total_count },
        include: ['player_participations.player'] + params[:include].to_s.split(',')
      }
    end

    private

    def filter_by_hero(matches)
      return matches if params[:hero_id].blank?

      matches
        .joins(:player_participations)
        .where(player_participations: { hero_id: params[:hero_id] })
    end

    def filter_by_side(matches)
      return matches if params[:side].blank?

      matches
        .joins(:player_participations)
        .where(player_participations: { side: params[:side] })
        .distinct
    end

    def filter_by_lanes(matches)
      return matches if params[:lanes].blank?

      matches
        .joins(:player_participations)
        .where(player_participations: { lane: params[:lanes] })
        .distinct
    end

    def filter_by_result(matches)
      return matches if params[:hero_id].blank? || params[:include_losses] == 'true'

      matches
        .joins(:player_participations)
        .where('player_participations.side = matches.winner')
        .distinct
    end

    def filter_by_role(matches)
      return matches if params[:role].blank?

      matches
        .joins(:player_participations)
        .where(player_participations: { role: params[:role] })
        .distinct
    end

    def filter_by_regions(matches)
      if params[:regions].blank?
        matches
      else
        matches.where(region: params[:regions])
      end
    end

    def filter_by_duration(matches)
      if params[:duration].blank?
        matches
      else
        matches.where('duration >= ?', params[:duration].to_i)
      end
    end

    def matches
      params[:user_id].present? ? Match.where(user_id: params[:user_id]) : Match.top
    end

    def ordered_matches
      case params[:sort]
      when 'average_mmr'
        matches.order(average_mmr: :desc)
      else
        matches.order(started_at: :desc)
      end
    end

    def filtered_matches
      FILTERS.inject(ordered_matches) do |matches, filter|
        __send__(filter, matches)
      end
    end

    def paginated_matches
      @paginated_matches ||= filtered_matches
        .includes(
          player_participations: [:hero, :player],
          match_comparisons: [other_match: [:match_comparisons, player_participations: [:hero, :player]]]
        )
        .page(params[:page])
        .per(params[:per_page])
    end
  end
end
