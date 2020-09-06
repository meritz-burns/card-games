module Types
  class World < BaseObject
    description <<~DESC
      The game state.
    DESC

    field :deck_size, Integer, null: false,
      description: "Number of cards remaining in the deck."
    field :top_of_discard_pile, Card, null: true,
      description: "The card visible on top of the discard pile, if any."
    field :players, [Player], null: false,
      description: "Everyone who is connected to this game, be they player or spectator."
  end
end
