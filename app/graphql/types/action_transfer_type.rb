module Types
  class ActionTransferType < BaseObject
    implements ActionType

    description <<~DESC
      the player took an installed card from another player and installed it on
      their own board
    DESC

    field :card, CardType, "the card that was transfered", null: false

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
