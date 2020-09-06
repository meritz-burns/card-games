module Types
  class PotentialCard < BaseUnion
    description <<~DESC
      Either a fully-described card, or a masked card, depending on what we're
      allowed to see.
    DESC

    possible_types MaskedCard, Card

    def self.from_player_card(player, card, current_player:)
      if player == current_player
        Card.from_card(card)
      else
        MaskedCard.from_card(card)
      end
    end
  end
end
