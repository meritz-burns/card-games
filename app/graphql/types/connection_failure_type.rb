module Types
  class ConnectionFailureType < BaseObject
    description <<~DESC
      Failed to connect to a game.
    DESC

    field :game_id, String, null: true,
      description: "The game they attempted to connect to."
    field :errors, [ErrorType], null: false,
      description: "Details of the connection failure."

    def self.from_errors(errors, game_id:)
      {
        game_id: game_id,
        errors: ErrorType.from_errors(errors),
      }
    end
  end
end
