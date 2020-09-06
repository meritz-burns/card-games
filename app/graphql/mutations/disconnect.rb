module Mutations
  class Disconnect < BaseMutation
    description <<~DESC
      Forfeit the game.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
