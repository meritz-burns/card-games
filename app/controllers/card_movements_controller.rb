class CardMovementsController < ApplicationController
  def create
    movement = CardMovement.from_connection(params[:player_id])

    if movement.move(movement_params)
      redirect_to [movement.player, movement.game]
    else
      Rails.logger.error("could not move: #{movement.errors.full_messages.join('. ')}")
      redirect_to [movement.player, movement.game],
        alert: movement.errors.full_messages.join(". ")
    end
  end

  private

  def movement_params
    params.require(:card_movement).permit(:source, :dest_pile)
  end
end
