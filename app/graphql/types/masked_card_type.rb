module Types
  class MaskedCardType < BaseObject
    description <<~DESC
      The back of a card. We have no idea what's on front.
    DESC

    field :ignored, String, null: true

    def self.from_card(card)
      { ignored: "" }
    end
  end
end
