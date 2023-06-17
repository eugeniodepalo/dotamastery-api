module Dotabuff
  class Client
    def find_players(id)
      page = Nokogiri::HTML(connection.get("matches/#{id}").body)
      return if !page.css('.truesight-intro .title').present? || !page.css('.player-lane-text acronym').present?

      page.css('.match-team-table tbody tr').map do |player|
        { lane: lane_for(player), role: role_for(player) }
      end
    rescue Faraday::ResourceNotFound
    end

    private

    def lane_for(player)
      player.css('.player-lane-text acronym').first.text.strip.match(/\w+(?:\s\w+)?/)[0].gsub(' ', '-').underscore
    end

    def role_for(player)
      player.css('.role-icon').first['title'].sub(/(.*) Role/i, '\1').underscore
    end

    def connection
      @connection ||= Faraday.new(:url => 'https://www.dotabuff.com') do |connection|
        connection.adapter Faraday.default_adapter
        connection.response :raise_error
      end
    end
  end
end
