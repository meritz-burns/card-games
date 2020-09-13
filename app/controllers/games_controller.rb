class GamesController < ApplicationController
  def index
    @games = Game.joinable
  end

  def new
    @game = Game.new
  end

  def create
    game = Game.create!
    (_, player) = Game.join!(game.id)
    redirect_to player_game_path(player.connection_secret)
  end

  def show
    @movement = CardMovement.from_connection(params[:player_id])
    @player = @movement.player
    @game = @movement.game
  end
end
