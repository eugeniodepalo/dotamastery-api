class ApplicationJob < ActiveJob::Base
  include Failsafe

  around_perform do |job, block|
    job.failsafe(&block)
  end
end
