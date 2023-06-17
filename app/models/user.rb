class User < ApplicationRecord
  include Importable

  has_secure_token :auth_token
  has_many :matches, dependent: :destroy
  has_many :job_statuses, dependent: :destroy
  validates :name, presence: true
end
