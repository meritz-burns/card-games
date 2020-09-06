module Types
  class ConnectionPayload < BaseUnion
    description <<~DESC
      What happens when a user attempts to connect to a game.
    DESC

    possible_types ConnectionFailure, Connection

    def self.from_game(game, player:)
      Connection.from_game(game, player: player)
    end

    def self.from_errors(errors, game_id:)
      ConnectionFailure.from_errors(result.errors, game_id: game_id)
    end
  end
end
