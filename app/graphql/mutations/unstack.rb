module Mutations
  class Unstack < BaseMutation
    description <<~DESC
      Move the specified card from hand to the bottom of the deck.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
