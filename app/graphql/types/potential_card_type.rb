module Types
  class PotentialCardType < BaseUnion
    description <<~DESC
      Either a fully-described card, or a masked card, depending on what we're
      allowed to see.
    DESC

    possible_types MaskedCardType, CardType

    def self.resolve_type(object, _context)
      if object.has_key?(:name)
        CardType
      else
        MaskedCardType
      end
    end

    def self.from_player_card(player, card, current_player:)
      if player == current_player
        CardType.from_card(card)
      else
        MaskedCardType.from_card(card)
      end
    end
  end
end
