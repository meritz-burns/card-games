class Card < Struct.new(:name, :type, :charge, :ability, :id)
  def self.names
    CARDS.keys
  end

  def self.find(id)
    CARDS[extract_name(id)].clone.tap do |card|
      card.id = id
    end
  end

  def self.generate_identifier(card_name, *prefixes)
    encryption.encrypt((prefixes + [card_name]).join("_"))
  end

  def to_partial_path
    "cards/card"
  end

  private

  def self.extract_name(identifier)
    encryption.decrypt(identifier).split('_')[-1]
  end

  def self.encryption
    @_encryption ||= CardIdEncryption.new
  end

  CARDS = {
    "Rift" => Card.new(
      "Rift",
      :silver,
      1,
      "Draw a card or destroy a Nova in play",
    ),
    "Exotic Matter" => Card.new(
      "Exotic Matter",
      :silver,
      2,
      "You may install another Fuel Cell with a charge of six or less (a chain cannot exceed a charge of 10)",
    ),
    "Deflector" => Card.new(
      "Deflector",
      :silver,
      3,
      "If destroyed by an Anomaly's ability, draw a card or make a player discard a random card",
    ),
    "Anomaly" => Card.new(
      "Anomaly",
      :bronze,
      4,
      "Destroy all Silver Fuel Cells in play (including your own)",
    ),
    "Wormhole" => Card.new(
      "Wormhole",
      :bronze,
      4,
      "Look through the discard pile. Take one card from it and add it to your hand",
    ),
    "Reactor" => Card.new(
      "Reactor",
      :silver,
      5,
      "This Fuel Cell is immune to defusing once installed (it is not immune to abilities)",
    ),
    "Rewind" => Card.new(
      "Rewind",
      :bronze,
      5,
      "Return an Installed Fuel Cell to the bottom of the deck",
    ),
    "Dark Energy" => Card.new(
      "Dark Energy",
      :bronze,
      6,
      "Transfer control of a Silver Fuel Cell in play. The ability is triggered for the new owner",
    ),
    "Future Shift" => Card.new(
      "Future Shift",
      :bronze,
      6,
      "Look at the top two cards of the deck. Return one to the top, then play the other however you want",
    ),
    "Singularity" => Card.new(
      "Singularity",
      :bronze,
      7,
      "Destroy all Bronze Fuel Cells in play (including your own)",
    ),
    "Antimatter" => Card.new(
      "Antimatter",
      :bronze,
      8,
      "Force an opponent to discard a random card from their hand, then one of their choice",
    ),
    "Time Stop" => Card.new(
      "Time Stop",
      :bronze,
      9,
      "Play any time a Bronze Fuel Cell is burned to cancel its ability (the stopped play gets another turn)",
    ),
    "Nova" => Card.new(
      "Nova",
      :bronze,
      10,
      "",
    ),
  }
end
