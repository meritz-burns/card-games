module Mutations
  class Unstack < BaseMutation
    description <<~DESC
      Move the specified card from hand to the bottom of the deck.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      movement = CardMovement.from_connection(connection_id)
      result = movement.move_card(card_id, from: :hand, to: :deck_bottom)

      if result.valid?
        Types::ActionPayload.from_game(result.payload, player: movement.player)
      else
        Types::ActionPayload.from_errors(result.errors)
      end
    end
  end
end
