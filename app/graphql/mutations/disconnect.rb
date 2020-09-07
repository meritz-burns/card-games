module Mutations
  class Disconnect < BaseMutation
    description <<~DESC
      Forfeit the game.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:)
      player = Player.find_by!(connection_id: connection_id)
      game = player.game

      if game.update(state: Game.states[:over])
        if other_player = game.players.detect { |p| p != player }
          action(:victory, other_player)
        end

        Types::ActionPayload.from_game(game, player: player)
      else
        Types::ActionPayload.from_errors(game.errors)
      end
    end
  end
end
