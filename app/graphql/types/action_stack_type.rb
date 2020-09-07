module Types
  class ActionStackType < BaseObject
    implements ActionType

    description <<~DESC
      the player put a card from their hand on top of the deck
    DESC

    def self.from_action(performing_player, _card_id, current_player:)
      world = World.game(current_player.game, player: current_player)

      {
        player: performing_player,
        world: world,
      }
    end
  end
end
