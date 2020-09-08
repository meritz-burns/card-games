module Types
  class ErrorType < BaseObject
    description <<~DESC
      An error occurred.
    DESC

    field :message, String, null: false,
      description: "The error message"
    field :path, [String], null: false,
      description: "The input value at fault."

    def self.from_errors(errors)
      errors.map do |path, message|
        {
          message: message,
          path: [path.to_s],
        }
      end
    end
  end
end
