class MatchesController < ApplicationController
  before_action :authenticate, if: -> { params[:user_id].present? }

  def index
    respond_to do |format|
      format.json do
        render IndexAction.new(params).render
      end
    end
  end
end
