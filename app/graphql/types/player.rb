module Types
  class Player < BaseObject
    description <<~DESC
      The public face of a game participant.
    DESC

    field :id, String, null: false,
      description: "A unique identifier for this player."
    field :name, String, null: false,
      description: "A human-readable name for our player."
    field :hand, [PotentialCard], null: false,
      description: "The player's hand. This value is different for each user who requests it; all other user's cards are masked."
    field :board, [Card], null: false,
      description: "The installed cards in front of the player."
  end
end
