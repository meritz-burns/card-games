module Mutations
  class Destroy < BaseMutation
    description <<~DESC
      Move an installed card to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:, card_id:)
      movement = CardMovement.from_connection(connection_id)
      result = movement.move(card_id, from: :installed, to: :discard)

      if result.valid?
        action(:destroy, movement.player, card_id)
        Types::ActionPayload.from_game(result.payload, player: movement.player)
      else
        Types::ActionPayload.from_errors(result.errors)
      end
    end
  end
end