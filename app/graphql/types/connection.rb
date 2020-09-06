module Types
  class Connection < BaseObject
    description <<~DESC
      The user successfully connected to a game. The id value here can be used
      for future actions.
    DESC

    field :id, String, null: false,
      description: "The unique identifier for this connection. Anyone with this value can play as this user."
    field :player, Player, null: false,
      description: "Public details about this player."
    field :world, World, null: false,
      description: "The game state."
  end
end
