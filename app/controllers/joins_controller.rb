class JoinsController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    game = Game.create!
    (_, player) = Game.join!(game.id)
    redirect_to player_game_path(player.connection_secret)
  end

  def update
    (_, player) = Game.join!(params[:game_id])
    redirect_to player_game_path(player.connection_secret)
  end
end
