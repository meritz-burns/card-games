module Mutations
  class Connect < BaseMutation
    description <<~DESC
      Connect to a game. If you are the first or second person to do you, you
      are a player; otherwise you are a spectator.

      You can only connect to a game that can be played. It is an error to
      connect to a game that is over.
    DESC

    argument :game_id, String, required: true
    type Types::ConnectionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
