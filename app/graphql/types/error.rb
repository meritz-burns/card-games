module Types
  class Error < BaseObject
    description <<~DESC
      An error occurred.
    DESC

    field :message, String, null: false,
      description: "The error message"
    field :path, [String], null: false,
      description: "The input value at fault."

    def self.from_error(error)
      {
        message: error.message,
        path: [], ### TODO not sure what to do here.
      }
    end
  end
end
