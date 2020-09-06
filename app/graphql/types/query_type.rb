module Types
  class QueryType < Types::BaseObject
    field :noop, String, null: false,
      description: "A query is required for the schema"

    def noop
      ""
    end
  end
end
