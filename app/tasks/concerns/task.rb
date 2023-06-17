module Task
  extend ActiveSupport::Concern
  include Failsafe

  class_methods do
    def perform(*args)
      new(*args).failsafe_perform
    end
  end

  def perform
    raise NotImplementedError
  end

  def failsafe_perform
    failsafe { perform }
  end
end
