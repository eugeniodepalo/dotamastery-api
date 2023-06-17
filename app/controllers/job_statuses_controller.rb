class JobStatusesController < ApplicationController
  before_action :authenticate

  def show
    params.permit(:format, :id)

    respond_to do |format|
      format.json { render json: JobStatus.find_or_initialize_by(user: current_user, name: params[:id]) }
    end
  end
end
