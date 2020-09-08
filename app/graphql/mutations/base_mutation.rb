module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject

    null false

    def action(name, current_player, card_id = nil)
      CntrlSchema.subscriptions.trigger(
        :action,
        {},
        [name, current_player, card_id],
      )
    end
  end
end
