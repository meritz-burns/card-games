module Mutations
  class Inspect < BaseMutation
    description <<~DESC
      List all the cards in the discard pile.
    DESC

    argument :connection_id, String, required: true
    type Types::InspectPayload

    def resolve(connection_id:)
      player = Player.find_by!(connection_id: connection_id)
      game = player.game

      Types::InspectPayload.from_cards(game.discard)
    end
  end
end
