module Importable
  extend ActiveSupport::Concern

  included do
    validates :original_id, presence: true
  end
end
