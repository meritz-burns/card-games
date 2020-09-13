##
# Represents a single game being played. Almost guaranteed to be the god class.
class Game < ApplicationRecord
  enum state: {
    :created => 0,
    :waiting => 1,
    :ongoing => 2,
    :over => 3,
  }

  before_create :set_up_game

  has_many :players

  ##
  # Games that can be joined, either as a spectator or player.
  #
  # @return [List<Game>]
  def self.joinable
    where('state <> ?', states[:over])
  end

  ##
  # This method helps a user join an existing game, either as the second player
  # or as a spectator.
  #
  # - If the game does not exist, error, return failure.
  # - If the game is OVER, error, return failure.
  # - If the game is CREATED, add player, move to WAITING, return success.
  # - If the game is WAITING, add player, move to ONGOING, return success.
  # - If the game is ONGOING, add spectator, return success.
  #
  # @param game_id [String] the game to join
  # @return [Game] whether it worked, with the new
  #   player and game in the success payload.
  def self.join!(game_id)
    ### TODO lock and txn
    game = find(game_id)

    case game.state
    when "created"
      player = game.add_player!("Player 1")
      game.update!(state: :waiting)
      [game, player]
    when "waiting"
      player = game.add_player!("Player 2")
      game.update!(state: :ongoing)
      [game, player]
    when "ongoing"
      spectator = game.add_spectator!
      [game, spectator]
    when "over"
      raise "Cannot join a finished game" ### TODO first class exn
    end
  end

  ##
  # Creates a new player and connects them to this game.
  #
  # @return [Player] The saved player.
  def add_player!(name)
    player = Player.create!(game: self, name: name)

    ### TODO draw five cards

    player
  end

  ##
  # Creates a new spectator and connects them to this game.
  #
  # @return [Player] The saved player.
  def add_spectator!
    Player.create!(game: self, name: "Spectator")
  end

  def deck
    deck_ids.map { |card_id| Card.find(card_id) }
  end

  def discard
    discard_ids.map { |card_id| Card.find(card_id) }
  end

  private

  def set_up_game
    self.deck_ids = (Card.names * 4).shuffle.map.with_index do |card_name, idx|
      Card.generate_identifier(card_name, id, idx)
    end
  end
end
