module Subscriptions
  ##
  # The +object+ is either +[type, player]+ or +[type, player, card_id]+.
  class Action < BaseSubscription
    description <<~DESC
      Subscribe to this for notifications on every action taken by other users
      in the game.
    DESC

    argument :connection_id, String, required: true
    payload_type Types::ActionType

    def update(connection_id:)
      action_name, player, card_id = object
      current_player = Player.find_by!(connection_secret: connection_id)

      if player == current_player || player.game_id != current_player.game_id
        :no_update
      else
        ### TODO
        ###  the docs say:
        ###  > #unsubscribe does _not_ halt the current update.
        ###  but the implementation is:
        ###  ```
        ###  def unsubscribe
        ###    raise UnsubscribedError
        ###  end
        ###  ```
        ###  so whta's the truth?
        if [:win, :disconnect].include?(action_name)
          unsubscribe
        end

        Types::ActionType.from_action(
          action_name,
          player,
          card_id,
          current_player: current_player,
        )
      end
    end
  end
end
