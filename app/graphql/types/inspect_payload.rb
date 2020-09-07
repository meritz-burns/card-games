module Types
  class InspectPayload < BaseObject
    description <<~DESC
      What happened when we tried to look at the discard pile.
    DESC

    field :errors, [ErrorType], null: false,
      description: "We hit errors along the way. It is unlikely that the list of cards is complete."
    field :cards, [CardType], null: false,
      description: "The cards in the discard pile, sorted with the most recent first."

    def self.from_cards(cards)
      {
        errors: [],
        cards: cards.map { |card| CardType.from_card(card) }
      }
    end
  end
end
