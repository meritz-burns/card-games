module Types
  class WorldType < BaseObject
    description <<~DESC
      The game state.
    DESC

    field :deck_size, Integer, null: false,
      description: "Number of cards remaining in the deck."
    field :top_of_discard_pile, CardType, null: true,
      description: "The card visible on top of the discard pile, if any."
    field :players, [PlayerType], null: false,
      description: "Everyone who is connected to this game, be they player or spectator."

    def self.from_game(game, player:)
      current_player = player

      {
        deck_size: game.deck.size,
        top_of_discard_pile: game.discard.first,
        players: game.players.map do |player|
          PlayerType.from_player(player, current_player: current_player)
        end,
      }
    end
  end
end
