if Rails.env.production?
  require 'exception_notification/rails'
  require 'exception_notification/sidekiq'

  ExceptionNotification.configure do |config|
    config.ignored_exceptions += [
      'ActionController::UnpermittedParameters',
      'Redis::TimeoutError',
      'SignalException'
    ]

    config.add_notifier :email, {
      email_prefix: '[EXCEPTION] ',
      sender_address: %{"Exception Notification" <exceptions@dotamastery.io>},
      exception_recipients: (ENV['EXCEPTION_NOTIFICATION_RECIPIENTS'] || '').split(',')
    }

    ExceptionNotifier::Rake.configure
  end
end
