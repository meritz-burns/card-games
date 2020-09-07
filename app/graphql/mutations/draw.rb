module Mutations
  class Draw < BaseMutation
    description <<~DESC
      Move a card from the top of the deck into hand.
    DESC

    argument :connection_id, String, required: true
    type Types::ActionPayload

    def resolve(connection_id:)
      movement = CardMovement.from_connection(connection_id)
      card_id = movement.game.deck_ids.first

      if card_id
        result = movement.move_card(card_id, from: :deck, to: :hand)

        if result.valid?
          action(:draw, movement.player, card_id)
          Types::ActionPayload.from_game(result.payload, player: movement.player)
        else
          Types::ActionPayload.from_errors(result.errors)
        end
      else
        ### TODO is this right -- or does this add a top-level `errors` key
        ###      instead of one inside the `data`?
        {
          errors: [
            {
              message: I18n.t("mutations.draw.empty_deck"), ### TODO i18n
              path: [],
            }
          ],
          world: nil,
        }
      end
    end
  end
end
