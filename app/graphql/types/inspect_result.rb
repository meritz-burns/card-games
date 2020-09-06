module Types
  class InspectResult < BaseObject
    description <<~DESC
      What happened when we tried to look at the discard pile.
    DESC

    field :errors, [Error], null: false,
      description: "We hit errors along the way. It is unlikely that the list of cards is complete."
    field :cards, [Card], null: false,
      description: "The cards in the discard pile, sorted with the most recent first."

    def self.from_cards(cards)
      cards.map { |card| Card.from_card(card) }
    end
  end
end
