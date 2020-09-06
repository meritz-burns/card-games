module Mutations
  class Discard < BaseMutation
    description <<~DESC
      Move the specified card from hand to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
