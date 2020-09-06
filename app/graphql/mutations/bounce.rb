module Mutations
  class Bounce < BaseMutation
    description <<~DESC
      Move the specified card from board into hand.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
