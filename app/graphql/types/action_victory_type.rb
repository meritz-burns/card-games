module Types
  class ActionVictoryType < BaseObject
    implements ActionType

    description <<~DESC
      a player has won; the game is over
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
