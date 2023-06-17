module Failsafe
  extend ActiveSupport::Concern

  class RetriableError < StandardError; end

  RETRIABLE_ERRORS = [
    Faraday::ConnectionFailed,
    Faraday::ParsingError,
    Faraday::TimeoutError,
    Steam::SteamError,
    Steam::JSONError,
    SignalException,
    RetriableError
  ]

  def failsafe
    Retriable.retriable(on: RETRIABLE_ERRORS, on_retry: Proc.new { |e| Rails.logger.warn(e) }) do
      begin
        yield
      rescue Faraday::ClientError => error
        if Failsafe.retriable_client_error?(error)
          raise RetriableError
        else
          raise
        end
      end
    end
  rescue ActiveRecord::RecordNotUnique, ActiveRecord::InvalidForeignKey => error
    Rails.logger.warn(error)
  rescue *RETRIABLE_ERRORS
  end

  def self.retriable_client_error?(error)
    error.response && (error.response[:status] == 429 || error.response[:status] >= 500)
  end
end
