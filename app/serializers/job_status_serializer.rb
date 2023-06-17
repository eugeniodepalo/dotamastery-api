class JobStatusSerializer < ApplicationSerializer
  attributes :id, :is_running

  def id
    object.name
  end

  def is_running
    object.running?
  end
end
