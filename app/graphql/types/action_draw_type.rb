module Types
  class ActionDrawType < BaseObject
    implements ActionType

    description <<~DESC
      the player drew a card from the deck
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
