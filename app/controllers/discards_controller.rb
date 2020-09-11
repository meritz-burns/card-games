class DiscardsController < ApplicationController
  def show
    player = Player.find_by!(connection_secret: params[:player_id])
    @game = player.game
  end
end
