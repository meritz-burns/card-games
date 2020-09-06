module Types
  class Card < BaseObject
    description <<~DESC
      A fuel cell.
    DESC

    field :id, String, null: false,
      description: "an identifier that fuel cell, but not necessarily for each object. For example, all Anomaly cards have the same id"
    field :charge, Integer, null: false,
      description: "how many fuel cells to add to the time machine's charge"
    field :type, CardMetal, null: false,
      description: "whether it is a silver or bronze fuel cell"
    field :name, String, null: false,
      description: "human-readable card name"
    field :ability, String, null: false,
      description: "what happens when you install or burn this card"
  end
end
