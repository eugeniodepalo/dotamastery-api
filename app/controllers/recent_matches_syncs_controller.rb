class RecentMatchesSyncsController < ApplicationController
  before_action :authenticate

  def create
    params.permit(:format)

    if SyncRecentMatchesJob.perform_unique(user: current_user)
      head :no_content
    else
      head :unprocessable_entity
    end
  end
end
