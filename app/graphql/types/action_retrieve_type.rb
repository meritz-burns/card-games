module Types
  class ActionRetrieveType < BaseObject
    implements ActionType

    description <<~DESC
      the player took a card from the discard pile into their hand
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
