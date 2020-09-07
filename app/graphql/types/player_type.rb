module Types
  class PlayerType < BaseObject
    description <<~DESC
      The public face of a game participant.
    DESC

    field :id, String, null: false,
      description: "A unique identifier for this player."
    field :name, String, null: false,
      description: "A human-readable name for our player."
    field :hand, [PotentialCardType], null: false,
      description: "The player's hand. This value is different for each user who requests it; all other user's cards are masked."
    field :board, [CardType], null: false,
      description: "The installed cards in front of the player."

    def self.from_player(player, current_player:)
      {
        id: player.id.to_s,
        name: player.name,
        hand: player.hand.map do |card|
          PotentialCardType.from_player_card(
            player,
            card,
            current_player: current_player,
          )
        end,
        board: player.installed.map { |card| CardType.from_card(card) }
      }
    end
  end
end
