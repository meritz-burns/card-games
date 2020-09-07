module Types
  class ActionUnstackType < BaseObject
    implements ActionType

    description <<~DESC
      the player put a card from their hand on the bottom of the deck
    DESC

    def self.from_action(performing_player, _card_id, current_player:)
      world = WorldType.from_game(current_player.game, player: current_player)

      {
        player: performing_player,
        world: world,
      }
    end
  end
end
