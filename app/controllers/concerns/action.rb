module Action
  extend ActiveSupport::Concern

  def initialize(params)
    @params = params
  end

  def render
    raise NotImplementedError
  end

  private

  attr_reader :params
end
