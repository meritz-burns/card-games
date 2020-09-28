class WinsController < ApplicationController
  def create
    player = Player.find_by!(connection_secret: params[:player_id])
    game = player.game

    if game.update(state: :over)
      redirect_to player_game_path(player)
    else
      redirect_to player_game_path(player),
        alert: game.errors.full_messages.join(". ")
    end
  end
end
