module Types
  class ActionPayload < BaseObject
    description <<~DESC
      What happened when the user tried to do something.
    DESC

    field :errors, [Error], null: false,
      description: "we encountered an error"
    field :world, World, null: true,
      description: "the updated gamestate, or null if there was an error"

    def self.from_game(game, player:)
      {
        errors: [],
        world: World.from_game(game, player: player),
      }
    end

    def self.from_errors(errors)
      {
        errors: errors.map { |error| Error.from_error(error) },
        world: nil,
      }
    end
  end
end
