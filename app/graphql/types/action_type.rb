module Types
  module ActionType
    include BaseInterface

    description <<~DESC
      An action that another user took in the game.
    DESC

    field :player, Player, "the player who took the action", null: false
    field :world, World, "the game state", null: false

    orphan_types ActionDestroyType,
      ActionDiscardType,
      ActionStackType,
      ActionUnstackType,
      ActionDrawType,
      ActionInstallType,
      ActionBounceType,
      ActionRetrieveType,
      ActionTransferType,
      ActionConnectType,
      ActionVictoryType

    def self.from_action(action_name, performing_player, card_id, current_player:)
      action_type_for(action_name).from_action(
        performing_player,
        card_id,
        current_player: current_player,
      )
    end

    def self.action_type_for(action_name)
      case action_name
      when :destroy
        ActionDestroyType
      when :discard
        ActionDiscardType
      when :stack
        ActionStackType
      when :unstack
        ActionUnstackType
      when :draw
        ActionDrawType
      when :install
        ActionInstallType
      when :bounce
        ActionBounceType
      when :retrieve
        ActionRetrieveType
      when :transfer
        ActionTransferType
      when :connect
        ActionConnectType
      when :victory
        ActionVictoryType
      else
        UnknownAction.new(action_name)
      end
    end

    class UnknownAction < Struct.new(:action_name)
      def from_action(*)
        raise "unknown action: #{action_name}"
      end
    end
  end
end
