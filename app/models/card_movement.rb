##
# A card can exist in one of four places:
#
# - deck,
# - discard pile,
# - installed for a player,
# - in a player's hand.
#
# This class orchestrates moving a card from one place to another within the
# same game.
class CardMovement
  attr_reader :game, :player

  ##
  # @param connection_secret [String] The player's secret identifier.
  # @return [CardMovement]
  def self.from_connection(connection_secret)
    player = Player.find_by!(connection_secret: connection_secret)
    game = player.game

    new(game: game, player: player)
  end

  ##
  # @param game [Game]
  # @param player [Player]
  # @return [CardMovement]
  def initialize(game:, player:)
    @game = game
    @player = player
  end

  ##
  # @param card_id [String]
  # @param from [Symbol]
  # @param to [Symbol]
  #
  # @return [Result:Success, Result::Failure]
  def move(card_id, from:, to:)
    case from
    when :deck
      case to
      when :hand
        if game.deck_ids.delete(card_id)
          player.hand_ids.append(card_id)

          ActiveRecord::Base.transaction do
            game.save!
            player.save!
          end

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_deck) ### TODO i18n
        end
      end
    when :discard
      case to
      when :hand
        if game.discard_ids.delete(card_id)
          player.hand_ids.append(card_id)

          ActiveRecord::Base.transaction do
            game.save!
            player.save!
          end

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_discard) ### TODO i18n
        end
      end
    when :hand
      case to
      when :deck
        if player.hand_ids.delete(card_id)
          game.deck_ids.prepend(card_id)

          ActiveRecord::Base.transaction do
            game.save!
            player.save!
          end

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_hand) ### TODO i18n
        end
      when :deck_bottom
        if player.hand_ids.delete(card_id)
          game.deck_ids.append(card_id)

          ActiveRecord::Base.transaction do
            game.save!
            player.save!
          end

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_hand) ### TODO i18n
        end
      when :discard
        if player.hand_ids.delete(card_id)
          game.discard_ids.prepend(card_id)

          ActiveRecord::Base.transaction do
            game.save!
            player.save!
          end

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_hand) ### TODO i18n
        end
      when :installed
        if player.hand_ids.delete(card_id)
          player.board_ids.append(card_id)

          player.save!

          Result::Success.new(game)
        else
          Result::Failure.new(:card_not_in_hand) ### TODO i18n
        end
      end
    when :installed
      case to
      when :discard
        source_player = game.players.detect do |player|
          player.board_ids.include?(card_id)
        end

        if source_player.nil?
          Result::Failure.new(:card_not_installed) ### TODO i18n
        else
          if source_player.board_ids.delete(card_id)
            game.discard_ids.prepend(card_id)

            ActiveRecord::Base.transaction do
              source_player.save!
              game.save!
            end

            Result::Success.new(game)
          else
            Result::Failure.new(:card_not_installed) ### TODO i18n
          end
        end
      when :hand
        source_player = game.players.detect do |player|
          player.board_ids.include?(card_id)
        end

        if source_player.nil?
          Result::Failure.new(:card_not_installed) ### TODO i18n
        else
          if source_player.board_ids.delete(card_id)
            player.hand_ids.append(card_id)

            ActiveRecord::Base.transaction do
              source_player.save!
              player.save!
            end

            Result::Success.new(game)
          else
            Result::Failure.new(:card_not_installed)
          end
        end
      when :installed
        source_player = game.players.detect do |player|
          player.board_ids.include?(card_id)
        end

        if source_player.nil?
          Result::Failure.new(:card_not_installed) ### TODO i18n
        else
          if source_player.board_ids.delete(card_id)
            player.board_ids.append(card_id)

            ActiveRecord::Base.transaction do
              source_player.save!
              player.save!
            end

            Result::Success.new(game)
          else
            Result::Failure.new(:card_not_installed)
          end
        end
      end
    end
  end
end
