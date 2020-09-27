class DiscardsController < ApplicationController
  def show
    @movement = CardMovement.from_connection(params[:player_id])
    @player = @movement.player
    @game = @movement.game
    @movement.dest_pile = "pile-player-hand-#{@player.id}"
  end
end
