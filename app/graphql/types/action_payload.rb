module Types
  class ActionPayload < BaseObject
    description <<~DESC
      What happened when the user tried to do something.
    DESC

    field :errors, [Error], null: false,
      description: "we encountered an error"
    field :world, World, null: true,
      description: "the updated gamestate, or null if there was an error"
  end
end
