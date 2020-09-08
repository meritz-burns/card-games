module Types
  class ConnectionPayload < BaseUnion
    description <<~DESC
      What happens when a user attempts to connect to a game.
    DESC

    possible_types ConnectionFailureType, ConnectionType

    def self.resolve_type(object, _context)
      if object.has_key?(:errors)
        ConnectionFailureType
      elsif object.has_key?(:id)
        ConnectionType
      end
    end

    def self.from_game(game, player:)
      ConnectionType.from_game(game, player: player)
    end

    def self.from_errors(errors, game_id:)
      ConnectionFailureType.from_errors(errors, game_id: game_id)
    end
  end
end
