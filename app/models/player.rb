class Player < ApplicationRecord
  belongs_to :game

  before_create :set_connection_secret

  def hand
    hand_ids.map { |card_id| Card.find(card_id) }
  end

  def board
    board_ids.map { |card_id| Card.find(card_id) }
  end

  def opponents
    game.players - [self]
  end

  def to_param
    connection_secret
  end

  private

  def set_connection_secret
    self.connection_secret = SecureRandom.uuid
  end
end
