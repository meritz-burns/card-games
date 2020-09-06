##
# Represents a single game being played. Almost guaranteed to be the god class.
class Game < ApplicationRecord
  STATES = [
    STATE_CREATED = "created".freeze,
    STATE_ONGOING = "ongoing".freeze,
    STATE_OVER = "over".freeze
  ].freeze

  ##
  # Games that can be joined, either as a spectator or player.
  #
  # @return [List<Game>]
  def self.joinable
    where('state <> ?', STATE_OVER)
  end

  ### TODO this is now no longer used:
  ##
  # This method helps a user join an existing game, either as the second player
  # or as a spectator. It takes a form object that it uses to communicate
  # errors.
  #
  # - If the game does not exist, error, return nil.
  # - If the game is OVER, error, return nil.
  # - If the game is CREATED, add player and move to ONGOING, return Game.
  # - If the game is ONGOING, add spectator, return Game.
  #
  # @param form [#game_id, ActiveModel::Model] the form object to communicate with
  # @return [Game, nil] a Game that has been joined, or nil
  def self.join(form)
    ### TODO lock and txn
    game = find(form.game_id)

    if game
      case game.state
      when STATE_CREATED
        if game.add_player
          game
        else
          form.errors.merge!(game.errors)
          nil
        end
      when STATE_ONGOING
        if game.add_spectator
          game
        else
          form.errors.merge!(game.errors)
          nil
        end
      when STATE_OVER
        form.errors.add(:game_id, :over) ### TODO
        nil
      end
    else
      form.errors.add(:game_id, :missing) ### TODO
      nil
    end
  end

  ##
  # Creates a new player and connects them to this game.
  #
  # @return [Boolean] Whether the player was added.
  def add_player
    TODO
  end

  ##
  # Creates a new spectator and connects them to this game.
  #
  # @return [Boolean] Whether the spectator was added.
  def add_spectator
    TODO
  end
end
