require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    Digest::SHA256.hexdigest(username), Digest::SHA256.hexdigest(Rails.configuration.x.sidekiq.username)
  ) & ActiveSupport::SecurityUtils.secure_compare(
    Digest::SHA256.hexdigest(password), Digest::SHA256.hexdigest(Rails.configuration.x.sidekiq.password)
  )
end if Rails.env.production?

Rails.application.routes.draw do
  resources :matches, only: :index
  resources :heroes, only: :index
  resources :users, only: :show
  resources :job_statuses, path: 'job-statuses', only: :show
  resources :recent_matches_syncs, path: 'recent-matches-syncs'
  resources :sessions, path: '/auth/:provider/callback', only: :create
  mount Sidekiq::Web, at: '/sidekiq'
end
