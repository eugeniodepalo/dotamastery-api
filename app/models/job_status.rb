class JobStatus < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  def running?
    persisted?
  end
end
