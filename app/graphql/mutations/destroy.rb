module Mutations
  class Destroy < BaseMutation
    description <<~DESC
      Move an installed card to the top of the discard pile.
    DESC

    argument :connection_id, String, required: true
    argument :card_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
