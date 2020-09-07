module Mutations
  class DiscardRandom < BaseMutation
    description <<~DESC
      Move a random card from hand to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:)
      movement = CardMovement.from_connection(connection_id)
      player = movement.player
      card_id = player.hand_ids.sample

      if card_id
        result = movement.move(card_id, from: :hand, to: :discard)

        if result.valid?
          action(:discard, player, card_id)
          Types::ActionPayload.from_game(result.payload, player: player)
        else
          Types::ActionPayload.from_errors(result.errors)
        end
      else
        action(:discard, player)
        Types::ActionPayload.from_game(movement.game, player: player)
      end
    end
  end
end
