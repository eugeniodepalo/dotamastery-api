class UsersController < ApplicationController
  before_action :authenticate

  def show
    params.permit(:format, :id)
    user = User.find(params[:id])
    authorize(user)

    respond_to do |format|
      format.json { render json: user }
    end
  end
end
