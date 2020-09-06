module Mutations
  class Stack < BaseMutation
    description <<~DESC
      Move the specified card from hand to the top of the deck.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
