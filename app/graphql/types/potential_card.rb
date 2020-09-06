module Types
  class PotentialCard < BaseUnion
    description <<~DESC
      Either a fully-described card, or a masked card, depending on what we're
      allowed to see.
    DESC

    possible_types MaskedCard, Card
  end
end
