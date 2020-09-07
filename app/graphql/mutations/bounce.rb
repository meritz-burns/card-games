module Mutations
  class Bounce < BaseMutation
    description <<~DESC
      Move the specified card from board into hand.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:, card_id:)
      movement = CardMovement.from_connection(connection_id)
      result = movement.move_card(card_id, from: :installed, to: :hand)

      if result.valid?
        action(:bounce, movement.player, card_id)
        Types::ActionPayload.from_game(result.payload, player: movement.player)
      else
        Types::ActionPayload.from_errors(result.errors)
      end
    end
  end
end
