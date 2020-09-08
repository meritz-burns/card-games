module Types
  class ActionPayload < BaseObject
    description <<~DESC
      What happened when the user tried to do something.
    DESC

    field :errors, [ErrorType], null: false,
      description: "we encountered an error"
    field :world, WorldType, null: true,
      description: "the updated gamestate, or null if there was an error"

    def self.from_game(game, player:)
      {
        errors: [],
        world: WorldType.from_game(game, player: player),
      }
    end

    def self.from_errors(errors)
      {
        errors: ErrorType.from_errors(errors),
        world: nil,
      }
    end
  end
end
