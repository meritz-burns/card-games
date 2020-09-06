module Mutations
  class Inspect < BaseMutation
    description <<~DESC
      List all the cards in the discard pile.
    DESC

    argument :connection_id, String, required: true
    type Types::InspectResult

    def resolve
      raise "not yet implemented"
    end
  end
end
