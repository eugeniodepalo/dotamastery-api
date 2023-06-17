module Authentication
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user

  def authenticate
    authenticate_or_request_with_http_token do |token|
      user = User.find_by_auth_token(token)

      if user
        self.current_user = user
      else
        false
      end
    end
  end

  private

  attr_writer :current_user
end
