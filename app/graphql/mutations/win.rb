module Mutations
  class Win < BaseMutation
    description <<~DESC
      End the game as a winner.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
