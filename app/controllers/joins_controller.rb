class JoinsController < ApplicationController
  def new
:   @game = Game.new
  end

  def create
    redirect_to Game.find(params[:id])
  end
end
