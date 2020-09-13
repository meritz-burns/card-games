##
# A card can exist in one of four places:
#
# - deck,
# - discard pile,
# - installed for a player,
# - in a player's hand.
#
# This class orchestrates moving a card from one place to another within a
# game.
class CardMovement
  include ActiveModel::Model

  attr_accessor :game, :source, :source_card, :source_pile, :dest_pile
  attr_accessor :player

  ##
  # @param connection_secret [String] The player's secret identifier.
  # @return [CardMovement]
  def self.from_connection(connection_secret)
    player = Player.find_by!(connection_secret: connection_secret)
    game = player.game

    new(game: game, player: player)
  end

  def source=(card_pile)
    (self.source_card, self.source_pile) = card_pile.split("-in-")
    @source = card_pile
  end

  ##
  # Adds to errors on failure.
  #
  # @param params [Hash]
  # @option params [String] :source a card in its pile
  # @option params [String] :source_card the card to move
  # @option params [String] :source_pile the pile it's coming from
  # @option params [String] :dest_pile the pile it's going to
  # @return [Boolean] whether it worked
  def move(params)
    assign_attributes(params)

    case source_pile
    when /pile-player-hand-(.*)/
      source_player = game.players.find($1)
      move_from_hand(source_pile, source_player, source_card, dest_pile)
    when /pile-player-board-(.*)/
      source_player = game.players.find($1)
      move_from_board(source_pile, source_player, source_card, dest_pile)
    when 'pile-deck'
      move_from_deck(source_card, dest_pile)
    when 'pile-discard'
      move_from_discard(source_card, dest_pile)
    end
  end

  private

  def move_from_hand(source_pile, source_player, source_card, dest_pile)
    case dest_pile
    when /pile-player-hand-(.*)/
      raise "not implemented"
    when /pile-player-board-(.*)/
      target_player = game.players.find($1)

      if source_player.hand_ids.delete(source_card)
        target_player.board_ids.append(source_card)

        ActiveRecord::Base.transaction do
          source_player.save!
          target_player.save!
        end

        broadcast(
          source_card: source_card,
          source_pile: source_pile,
          dest_pile: dest_pile,
          extra: { card_id: source_card },
        )

        true
      else
        errors.add(:source, :not_in_hand)
        false
      end
    when 'pile-deck'
      if source_player.hand_ids.delete(source_card)
        game.deck_ids.prepend(source_card)

        ActiveRecord::Base.transaction do
          game.save!
          source_player.save!
        end

        broadcast(
          source_pile: source_pile,
          dest_pile: dest_pile,
          extra: {
            card_id: source_card,
            new_top_card_id: game.deck_ids.first,
          },
        )

        true
      else
        errors.add(:source, :not_in_hand)
        false
      end
    when 'pile-deck-bottom'
      if source_player.hand_ids.delete(source_card)
        game.deck_ids.append(source_card)

        ActiveRecord::Base.transaction do
          game.save!
          source_player.save!
        end

        broadcast(
          source_pile: source_pile,
          dest_pile: dest_pile,
          extra: {
            card_id: source_card,
            new_top_card_id: game.deck_ids.first,
          },
        )

        true
      else
        errors.add(:source, :not_in_hand)
        false
      end
    when 'pile-discard'
      if source_player.hand_ids.delete(source_card)
        game.discard_ids.prepend(source_card)

        ActiveRecord::Base.transaction do
          game.save!
          source_player.save!
        end

        broadcast(
          source_pile: source_pile,
          dest_pile: dest_pile,
          extra: {
            discard: game.discard.first,
            card_id: source_card,
          },
        )

        true
      else
        errors.add(:source, :not_in_hand)
        false
      end
    end
  end

  def move_from_board(source_pile, source_player, source_card, dest_pile)
    case dest_pile
    when /pile-player-hand-(.*)/
      target_player = game.players.find($1)

      if source_player.board_ids.delete(source_card)
        target_player.hand_ids.append(source_card)

        ActiveRecord::Base.transaction do
          source_player.save!
          target_player.save!
        end

        broadcast(
          source_card: source_card,
          source_pile: source_pile,
          dest_pile: dest_pile,
        )

        true
      else
        errors.add(:source, :not_installed)
        false
      end
    when /pile-player-board-(.*)/
      target_player = game.players.find($1)

      if source_player.board_ids.delete(source_card)
        target_player.board_ids.append(source_card)

        ActiveRecord::Base.transaction do
          source_player.save!
          target_player.save!
        end

        broadcast(
          source_card: source_card,
          source_pile: source_pile,
          dest_pile: dest_pile,
        )

        true
      else
        errors.add(:source, :not_installed)
        false
      end
    when 'pile-deck'
      raise "not implemented"
    when 'pile-deck-bottom'
      raise "not implemented"
    when 'pile-discard'
      if source_player.board_ids.delete(source_card)
        game.discard_ids.prepend(source_card)

        ActiveRecord::Base.transaction do
          source_player.save!
          game.save!
        end

        broadcast(
          source_card: source_card,
          source_pile: source_pile,
          dest_pile: dest_pile,
        )

        true
      else
        errors.add(:source, :not_installed)
        false
      end
    end
  end

  def move_from_deck(source_card, dest_pile)
    case dest_pile
    when /pile-player-hand-(.*)/
      player = game.players.find($1)

      if game.deck_ids.delete(source_card)
        player.hand_ids.append(source_card)

        ActiveRecord::Base.transaction do
          game.save!
          player.save!
        end

        broadcast(
          source_pile: "pile-deck",
          dest_pile: dest_pile,
          extra: { new_top_card_id: game.deck_ids.first },
        )

        true
      else
        errors.add(:source, :not_in_deck)
        false
      end
    when /pile-player-board/
      raise "not implemented"
    when 'pile-deck'
      raise "not implemented"
    when 'pile-discard'
      raise "not implemented"
    end
  end

  def move_from_discard(source_card, dest_pile)
    case dest_pile
    when /pile-player-hand-(.*)/
      player = game.players.find($1)

      if game.discard_ids.delete(source_card)
        player.hand_ids.append(source_card)

        ActiveRecord::Base.transaction do
          game.save!
          player.save!
        end

        broadcast(
          source_pile: "pile-discard",
          dest_pile: dest_pile,
          extra: { discard: game.discard.first },
        )

        true
      else
        errors.add(:source, :not_in_discard)
        false
      end
    when /pile-player-board/
      raise "not implemented"
    when 'pile-deck'
      raise "not implemented"
    when 'pile-discard'
      raise "not implemented"
    end
  end

  def broadcast(source_card: nil, source_pile:, dest_pile:, extra: {})
    card = source_card && Card.find(source_card)
    payload = {
      source_card: card,
      source_pile: source_pile,
      source_pile_type: pile_type(source_pile),
      dest_pile: dest_pile,
      dest_pile_type: pile_type(dest_pile),
      extra: extra,
    }

    player.opponents.each do |opponent|
      ActionChannel.broadcast_to(opponent, payload)
    end
  end

  def pile_type(pile_name)
    case pile_name
    when /pile-player-hand/
      :hand
    when /pile-player-board/
      :board
    when /pile-deck/
      :deck
    when 'pile-discard'
      :discard
    end
  end
end
