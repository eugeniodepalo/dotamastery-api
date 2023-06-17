module UserJob
  extend ActiveSupport::Concern

  attr_reader :status

  class_methods do
    def perform_unique(args)
      perform_later(args)
    rescue ActiveRecord::RecordNotUnique
      false
    end
  end

  included do
    before_enqueue(prepend: true) { create_status! }

    around_perform prepend: true do |job, block|
      begin
        block.call
      ensure
        job.status.destroy
      end
    end
  end

  def create_status!
    @status = JobStatus.create!(user: user, name: name)
  end

  def status
    @status ||= JobStatus.find_by(user: user, name: name)
  end

  def name
    self.class.name.sub(/(.*)Job/i, '\1').underscore.dasherize
  end

  def user
    arguments.first[:user]
  end
end
