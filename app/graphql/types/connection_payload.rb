module Types
  class ConnectionPayload < BaseUnion
    description <<~DESC
      What happens when a user attempts to connect to a game.
    DESC

    possible_types ConnectionFailure, Connection
  end
end
