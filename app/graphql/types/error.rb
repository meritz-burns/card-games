module Types
  class Error < BaseObject
    description <<~DESC
      An error occurred.
    DESC

    field :message, String, null: false,
      description: "The error message"
    field :path, [String], null: false,
      description: "The input value at fault."
  end
end
