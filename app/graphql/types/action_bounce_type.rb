module Types
  class ActionBounceType < BaseObject
    implements ActionType

    description <<~DESC
      the player put an installed card in their hand
    DESC

    field :card, CardType, "the card that was bounced", null: false

    def self.from_action(performing_player, card_id, current_player:)
      world = WorldType.from_game(current_player.game, player: current_player)

      {
        player: performing_player,
        world: world,
        card: Card.find(card_id),
      }
    end
  end
end
