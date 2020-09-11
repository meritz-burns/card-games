class LosesController < ApplicationController
  def create
    player = Player.find_by!(connection_secret: params[:player_id])
    game = player.game

    if game.update(state: :over)
      redirect_to game
    else
      redirect_to game, alert: game.errors.full_messages.join(". ")
    end
  end
end
