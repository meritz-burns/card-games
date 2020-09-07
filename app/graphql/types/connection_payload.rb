module Types
  class ConnectionPayload < BaseUnion
    description <<~DESC
      What happens when a user attempts to connect to a game.
    DESC

    possible_types ConnectionFailureType, ConnectionType

    def self.from_game(game, player:)
      ConnectionType.from_game(game, player: player)
    end

    def self.from_errors(errors, game_id:)
      ConnectionFailureType.from_errors(result.errors, game_id: game_id)
    end
  end
end
