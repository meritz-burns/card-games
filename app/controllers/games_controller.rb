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
    @player = Player.find_by!(connection_secret: params[:player_id])
    @game = @player.game
    @movement = CardMovement.new(game: @game)
  end
end
