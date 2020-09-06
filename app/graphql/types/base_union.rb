module Types
  class BaseUnion < GraphQL::Schema::Union
    def self.resolve_type(object, _context)
      object.to_graphql_type
    end
  end
end
