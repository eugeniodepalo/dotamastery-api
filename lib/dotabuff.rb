module Dotabuff
  def self.client
    @client ||= Client.new
  end
end
