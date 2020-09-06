module Mutations
  class Transfer < BaseMutation
    description <<~DESC
      Move the specified card from another player's board into our board.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
