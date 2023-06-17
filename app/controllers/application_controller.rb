class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Authentication
  include Pundit
end
