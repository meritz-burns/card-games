module Types
  class CardType < BaseObject
    description <<~DESC
      A fuel cell.
    DESC

    field :id, String, null: false,
      description: "an identifier for this specific fuel cell"
    field :charge, Integer, null: false,
      description: "how many fuel cells to add to the time machine's charge"
    field :type, CardMetalType, null: false,
      description: "whether it is a silver or bronze fuel cell"
    field :name, String, null: false,
      description: "human-readable card name"
    field :ability, String, null: false,
      description: "what happens when you install or burn this card"

    def self.from_card(card)
      {
        id: card.id,
        charge: card.charge,
        type: card.type.to_sym,
        name: card.name,
        ability: card.ability,
      }
    end
  end
end
