module Types
  class ActionDiscardType < BaseObject
    implements ActionType

    description <<~DESC
      the player discarded a card
    DESC

    field :card, Card, "the card that was discarded", null: false

    def self.from_action(performing_player, card_id, current_player:)
      world = World.game(current_player.game, player: current_player)

      {
        player: performing_player,
        world: world,
        card: Card.find(card_id),
      }
    end
  end
end
