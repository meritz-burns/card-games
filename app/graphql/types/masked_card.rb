module Types
  class MaskedCard < BaseObject
    description <<~DESC
      The back of a card. We have no idea what's on front.
    DESC

    field :ignored, String, null: true
  end
end
