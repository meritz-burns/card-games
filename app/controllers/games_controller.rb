class GamesController < ApplicationController
  def index
    @games = Game.joinable
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
