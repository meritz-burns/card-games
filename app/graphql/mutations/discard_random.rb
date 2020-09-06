module Mutations
  class DiscardRandom < BaseMutation
    description <<~DESC
      Move a random card from hand to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
