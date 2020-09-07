module Mutations
  class Win < BaseMutation
    description <<~DESC
      End the game as a winner.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:)
      player = Player.find_by!(connection_id: connection_id)
      game = player.game

      if game.update(state: Game.states[:over])
        action(:victory, movement.player)
        Types::ActionPayload.from_game(game, player: player)
      else
        Types::ActionPayload.from_errors(game.errors)
      end
    end
  end
end
