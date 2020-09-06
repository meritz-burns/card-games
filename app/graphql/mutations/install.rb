module Mutations
  class Install < BaseMutation
    description <<~DESC
      Move a card from hand onto the board.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
