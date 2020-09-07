module Mutations
  class Discard < BaseMutation
    description <<~DESC
      Move the specified card from hand to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:, card_id:)
      movement = CardMovement.from_connection(connection_id)
      result = movement.move(card_id, from: :hand, to: :discard)

      if result.valid?
        action(:discard, movement.player, card_id)
        Types::ActionPayload.from_game(result.payload, player: movement.player)
      else
        Types::ActionPayload.from_errors(result.errors)
      end
    end
  end
end