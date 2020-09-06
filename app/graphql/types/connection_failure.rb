module Types
  class ConnectionFailure < BaseObject
    description <<~DESC
      Failed to connect to a game.
    DESC

    field :game_id, String, null: true,
      description: "The game they attempted to connect to."
    field :errors, [Error], null: false,
      description: "Details of the connection failure."
  end
end
