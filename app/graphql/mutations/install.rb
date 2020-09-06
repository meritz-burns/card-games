module Mutations
  class Install < BaseMutation
    description <<~DESC
      Move a card from hand onto the board.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:, card_id:)
      movement = CardMovement.from_connection(connection_id)
      result = movement.move_card(card_id, from: :hand, to: :installed)

      if result.valid?
        Types::ActionPayload.from_game(result.payload, player: movement.player)
      else
        Types::ActionPayload.from_errors(result.errors)
      end
    end
  end
end
