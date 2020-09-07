module Types
  class ActionConnectType < BaseObject
    implements ActionType

    description <<~DESC
      a player has connected
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
