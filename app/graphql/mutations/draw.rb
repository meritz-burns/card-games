module Mutations
  class Draw < BaseMutation
    description <<~DESC
      Move a card from the top of the deck into hand.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
