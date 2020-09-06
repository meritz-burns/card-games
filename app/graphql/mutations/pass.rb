module Mutations
  class Pass < BaseMutation
    description <<~DESC
      Skip our turn.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve
      raise "not yet implemented"
    end
  end
end
