class HeroesController < ApplicationController
  def index
    params.permit(:format)

    respond_to do |format|
      format.json { render json: Hero.all }
    end
  end
end
