class Card < Struct.new(:title, :owner, :ops, :text, :id, :removed, :ongoing, :stage, :url, :cancels, :antireq, :affects, :allows, :prereq, :related, keyword_init: true)

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
    "Asia Scoring" => Card.new(
        id: 1,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "Presence: 3; Domination: 7; Control: 9; +1 VP per controlled Battleground country in Region; +1 VP per country controlled that is adjacent to enemy superpower; MAY NOT BE HELD!",
        title: "Asia Scoring",
        url: "http://twilightstrategy.com/2011/12/14/regions-asia/"
    ),
    "Europe Scoring" => Card.new(
        id: 2,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "Presence: 3; Domination: 7; Control: Automatic Victory; +1 VP per controlled Battleground country in Region; +1 VP per country controlled that is adjacent to enemy superpower; MAY NOT BE HELD!",
        title: "Europe Scoring",
        url: "http://twilightstrategy.com/2011/12/12/regions-europe/"
    ),
    "Middle East Scoring" => Card.new(
        id: 3,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "Presence: 3; Domination: 5; Control: 7; +1 VP per controlled Battleground country in Region; MAY NOT BE HELD!",
        title: "Middle East Scoring",
        url: "http://twilightstrategy.com/2012/02/13/regions-middle-east/"
    ),
    "Duck and Cover" => Card.new(
        id: 4,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: false,
        stage: 1,
        text: "Degrade the DEFCON level by 1. The US receives VP equal to 5 minus the current DEFCON level.",
        title: "Duck and Cover",
        url: "http://twilightstrategy.com/2011/12/12/duck-and-cover/"
    ),
    "Five Year Plan" => Card.new(
        id: 5,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: false,
        stage: 1,
        text: "The USSR must randomly discard a card. If the card has a US associated Event, the Event occurs immediately. If the card has a USSR associated Event or an Event applicable to both players, then the card must be discarded without triggering the Event.",
        title: "Five Year Plan",
        url: "http://twilightstrategy.com/2011/12/12/five-year-plan/"
    ),
    "The China Card" => Card.new(
        "cancels": 35,
        id: 6,
        ongoing: false,
        ops: 4,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "This card begins the game with the USSR. When played, the player receives +1 Operations to the Operations value of this card if it uses all its Operations in Asia. It is passed to the opponent once played. A player receives 1 VP for holding this card at the end of Turn 10.",
        title: "The China Card",
        url: "http://twilightstrategy.com/2012/10/31/the-china-card/"
    ),
    "Socialist Governments" => Card.new(
        "antireq": 83,
        id: 7,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: false,
        stage: 1,
        text: "Remove a total of 3 US Influence from any countries in Western Europe (removing no more than 2 Influence per country). This Event cannot be used after the \u201c#83 \u2013 The Iron Lady\u201d Event has been played.",
        title: "Socialist Governments",
        url: "http://twilightstrategy.com/2011/12/13/socialist-governments/"
    ),
    "Fidel*" => Card.new(
        id: 8,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Remove all US Influence from Cuba. USSR adds sufficient Influence in Cuba for Control.",
        title: "Fidel*",
        url: "http://twilightstrategy.com/2011/12/14/fidel/"
    ),
    "Vietnam Revolts*" => Card.new(
        id: 9,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Add 2 USSR Influence to Vietnam. For the remainder of the turn, the USSR receives +1 Operations to the Operations value of a card that uses all its Operations in Southeast Asia.",
        title: "Vietnam Revolts*",
        url: "http://twilightstrategy.com/2011/12/16/vietnam-revolts/"
    ),
    "Blockade*" => Card.new(
        id: 10,
        ongoing: false,
        ops: 1,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Unless the US immediately discards a card with an Operations value of 3 or more, remove all US Influence from West Germany.",
        title: "Blockade*",
        url: "http://twilightstrategy.com/2011/12/19/blockade/"
    ),
    "Korean War*" => Card.new(
        "affects": 59,
        id: 11,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "North Korea invades South Korea. Roll a die and subtract (-1) from the die roll for every US controlled country adjacent to South Korea. On a modified die roll of 4-6, the USSR receives 2 VP and replaces all US Influence in South Korea with USSR Influence. The USSR adds 2 to its Military Operations Track.",
        title: "Korean War*",
        url: "http://twilightstrategy.com/2011/12/25/korean-war/"
    ),
    "Romanian Abdication*" => Card.new(
        id: 12,
        ongoing: false,
        ops: 1,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Remove all US Influence from Romania. The USSR adds sufficient Influence to Romania for Control.",
        title: "Romanian Abdication*",
        url: "http://twilightstrategy.com/2012/01/02/romanian-abdication/"
    ),
    "Arab-Israeli War" => Card.new(
        "affects": 59,
        id: 13,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 1,
        text: "Pan-Arab Coalition invades Israel. Roll a die and subtract (-1) from the die roll for Israel, if it is US controlled, and for every US controlled country adjacent to Israel. On a modified die roll of 4-6, the USSR receives 2 VP and replaces all US Influence in Israel with USSR Influence. The USSR adds 2 to its Military Operations Track. This Event cannot be used after the \u201c#65 \u2013 Camp David Accords\u201d Event has been played.",
        title: "Arab-Israeli War",
        url: "http://twilightstrategy.com/2012/01/16/arab-israeli-war/"
    ),
    "Comecon*" => Card.new(
        id: 14,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Add 1 USSR Influence to each of 4 non-US controlled countries of Eastern Europe.",
        title: "Comecon*",
        url: "http://twilightstrategy.com/2012/01/24/comecon/"
    ),
    "Nasser*" => Card.new(
        id: 15,
        ongoing: false,
        ops: 1,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Add 2 USSR Influence to Egypt. The US removes half, rounded up, of its Influence from Egypt.",
        title: "Nasser*",
        url: "http://twilightstrategy.com/2012/02/06/nasser/"
    ),
    "Warsaw Pact Formed*" => Card.new(
        "allows": 21,
        id: 16,
        ongoing: true,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Remove all US influence from 4 countries in Eastern Europe or add 5 USSR Influence to any countries in Eastern Europe (adding no more than 2 Influence per country). This Event allows the \u201c#21 \u2013 NATO\u201d card to be played as an Event.",
        title: "Warsaw Pact Formed*",
        url: "http://twilightstrategy.com/2012/02/20/warsaw-pact-formed/"
    ),
    "De Gaulle Leads France*" => Card.new(
        "affects": 21,
        id: 17,
        ongoing: true,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Remove 2 US Influence from France and add 1 USSR Influence to France. This Event cancels the effect(s) of the \u201c#21 \u2013 NATO\u201d Event for France only.",
        title: "De Gaulle Leads France*",
        url: "http://twilightstrategy.com/2012/02/24/de-gaulle-leads-france/"
    ),
    "Captured Nazi Scientist*" => Card.new(
        id: 18,
        ongoing: false,
        ops: 1,
        owner: "neutral",
        removed: true,
        stage: 1,
        text: "Move the Space Race Marker ahead by 1 space.",
        title: "Captured Nazi Scientist*",
        url: "http://twilightstrategy.com/2012/02/27/captured-nazi-scientist/"
    ),
    "Truman Doctrine*" => Card.new(
        id: 19,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 1,
        text: "Remove all USSR Influence from a single uncontrolled country in Europe.",
        title: "Truman Doctrine*",
        url: "http://twilightstrategy.com/2012/03/02/truman-doctrine/"
    ),
    "Olympic Games" => Card.new(
        id: 20,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "This player sponsors the Olympics. The opponent must either participate or boycott. If the opponent participates, each player rolls a die and the sponsor adds 2 to their roll. The player with the highest modified die roll receives 2 VP (reroll ties). If the opponent boycotts, degrade the DEFCON level by 1 and the sponsor may conduct Operations as if they played a 4 Ops card.",
        title: "Olympic Games",
        url: "http://twilightstrategy.com/2012/03/12/olympic-games/"
    ),
    "NATO*" => Card.new(
        "affects": 36,
        id: 21,
        ongoing: true,
        ops: 4,
        owner: "us",
        "prereq": [
            16,
            23
        ],
        removed: true,
        stage: 1,
        text: "The USSR cannot make Coup Attempts or Realignment rolls against any US controlled countries in Europe. US controlled countries in Europe cannot be attacked by play of the \u201c#36 \u2013 Brush War\u201d Event. This card requires prior play of either the \u201c#16 \u2013 Warsaw Pact Formed\u201d or \u201c#23 \u2013 Marshall Plan\u201d Event(s) in order to be played as an Event.",
        title: "NATO*",
        url: "http://twilightstrategy.com/2012/03/12/nato/"
    ),
    "Independent Reds*" => Card.new(
        id: 22,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 1,
        text: "Add US Influence to either Yugoslavia, Romania, Bulgaria, Hungary, or Czechoslovakia so that it equals the USSR Influence in that country.",
        title: "Independent Reds*",
        url: "http://twilightstrategy.com/2012/03/13/independent-reds/"
    ),
    "Marshall Plan*" => Card.new(
        "allows": 21,
        id: 23,
        ongoing: true,
        ops: 4,
        owner: "us",
        removed: true,
        stage: 1,
        text: "Add 1 US Influence to each of any 7 non-USSR controlled countries in Western Europe. This Event allows the \u201c#21 \u2013 NATO\u201d card to be played as an Event.",
        title: "Marshall Plan*",
        url: "http://twilightstrategy.com/2012/03/16/marshall-plan/"
    ),
    "Indo-Pakistani War" => Card.new(
        "affects": 59,
        id: 24,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "India invades Pakistan or vice versa (player\u2019s choice). Roll a die and subtract (-1) from the die roll for every enemy controlled country adjacent to the target of the invasion (India or Pakistan). On a modified die roll of 4-6, the player receives 2 VP and replaces all the opponent\u2019s Influence in the target country with their Influence. The player adds 2 to its Military Operations Track.",
        title: "Indo-Pakistani War",
        url: "http://twilightstrategy.com/2012/03/19/indo-pakistani-war/"
    ),
    "Containment*" => Card.new(
        id: 25,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 1,
        text: "All Operations cards played by the US, for the remainder of this turn, receive +1 to their Operations value (to a maximum of 4 Operations per card).",
        title: "Containment*",
        url: "http://twilightstrategy.com/2012/03/20/containment/"
    ),
    "CIA Created*" => Card.new(
        id: 26,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 1,
        text: "The USSR reveals their hand of cards for this turn. The US may use the Operations value of this card to conduct Operations.",
        title: "CIA Created*",
        url: "http://twilightstrategy.com/2012/03/26/cia-created/"
    ),
    "US/Japan Mutual Defense Pact*" => Card.new(
        id: 27,
        ongoing: true,
        ops: 4,
        owner: "us",
        removed: true,
        stage: 1,
        text: "The US adds sufficient Influence to Japan for Control. The USSR cannot make Coup Attempts or Realignment rolls against Japan.",
        title: "US/Japan Mutual Defense Pact*",
        url: "http://twilightstrategy.com/2012/03/27/usjapan-mutual-defense-pact/"
    ),
    "Suez Crisis*" => Card.new(
        id: 28,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "Remove a total of 4 US Influence from France, the United Kingdom and Israel (removing no more than 2 Influence per country).",
        title: "Suez Crisis*",
        url: "http://twilightstrategy.com/2012/03/29/suez-crisis/"
    ),
    "East European Unrest" => Card.new(
        id: 29,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: false,
        stage: 1,
        text: "Early or Mid War: Remove 1 USSR Influence from 3 countries in Eastern Europe. Late War: Remove 2 USSR Influence from 3 countries in Eastern Europe.",
        title: "East European Unrest",
        url: "http://twilightstrategy.com/2012/04/02/east-european-unrest/"
    ),
    "Decolonization" => Card.new(
        id: 30,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 1,
        text: "Add 1 USSR Influence to each of any 4 countries in Africa and/or Southeast Asia.",
        title: "Decolonization",
        url: "http://twilightstrategy.com/2012/04/05/decolonization/"
    ),
    "Red Scare/Purge" => Card.new(
        id: 31,
        ongoing: false,
        ops: 4,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "All Operations cards played by the opponent, for the remainder of this turn, receive -1 to their Operations value (to a minimum value of 1 Operations point).",
        title: "Red Scare/Purge",
        url: "http://twilightstrategy.com/2012/04/23/red-scarepurge/"
    ),
    "UN Intervention" => Card.new(
        id: 32,
        ongoing: false,
        ops: 1,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "Play this card simultaneously with a card containing an opponent\u2019s associated Event. The opponent\u2019s associated Event is canceled but you may use the Operations value of the opponent\u2019s card to conduct Operations. This Event cannot be played during the Headline Phase.",
        title: "UN Intervention",
        url: "http://twilightstrategy.com/2012/05/07/un-intervention/"
    ),
    "De-Stalinization*" => Card.new(
        id: 33,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 1,
        text: "The USSR may reallocate up to a total of 4 Influence from one or more countries to any non-US controlled countries (adding no more than 2 Influence per country).",
        title: "De-Stalinization*",
        url: "http://twilightstrategy.com/2012/05/29/de-stalinization/"
    ),
    "Nuclear Test Ban" => Card.new(
        id: 34,
        ongoing: false,
        ops: 4,
        owner: "neutral",
        removed: false,
        stage: 1,
        text: "The player receives VP equal to the current DEFCON level minus 2 then improves the DEFCON level by 2.",
        title: "Nuclear Test Ban",
        url: "http://twilightstrategy.com/2012/06/11/nuclear-test-ban/"
    ),
    "Formosan Resolution*" => Card.new(
        id: 35,
        ongoing: true,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 1,
        text: "If this card\u2019s Event is in effect, Taiwan will be treated as a Battleground country, for scoring purposes only, if Taiwan is US controlled when the Asia Scoring Card is played. This Event is cancelled after the US has played the \u201c#6 \u2013 The China Card\u201d card.",
        title: "Formosan Resolution*",
        url: "http://twilightstrategy.com/2012/07/02/formosan-resolution/"
    ),
    "Brush War" => Card.new(
        "affects": 59,
        id: 36,
        ongoing: false,
        ops: 3,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "The player attacks any country with a stability number of 1 or 2. Roll a die and subtract (-1) from the die roll for every adjacent enemy controlled country. On a modified die roll of 3-6, the player receives 1 VP and replaces all the opponent\u2019s Influence in the target country with their Influence. The player adds 3 to its Military Operations Track.",
        title: "Brush War",
        url: "http://twilightstrategy.com/2012/09/04/brush-war/"
    ),
    "Central America Scoring" => Card.new(
        id: 37,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Presence: 1; Domination: 3; Control: 5; +1 VP per controlled Battleground country in Region; +1 VP per country controlled that is adjacent to enemy superpower; MAY NOT BE HELD!",
        title: "Central America Scoring",
        url: "http://twilightstrategy.com/2012/09/04/regions-central-america/"
    ),
    "Southeast Asia Scoring*" => Card.new(
        id: 38,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: true,
        stage: 2,
        text: "1 VP each for Control of Burma, Cambodia/Laos, Vietnam, Malaysia, Indonesia and the Philippines. 2 VP for Control of Thailand; MAY NOT BE HELD!",
        title: "Southeast Asia Scoring*",
        url: "http://twilightstrategy.com/2012/09/04/regions-southeast-asia/"
    ),
    "Arms Race" => Card.new(
        id: 39,
        ongoing: false,
        ops: 3,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Compare each player\u2019s value on the Military Operations Track. If the phasing player has a higher value than their opponent on the Military Operations Track, that player receives 1 VP. If the phasing player has a higher value than their opponent, and has met the \u201crequired\u201d amount, on the Military Operations Track, that player receives 3 VP instead.",
        title: "Arms Race",
        url: "http://twilightstrategy.com/2012/09/05/arms-race/"
    ),
    "Cuban Missile Crisis*" => Card.new(
        id: 40,
        ongoing: false,
        ops: 3,
        owner: "neutral",
        removed: true,
        stage: 2,
        text: "Set the DEFCON level to 2. Any Coup Attempts by your opponent, for the remainder of this turn, will result in Global Thermonuclear War. Your opponent will lose the game. This card\u2019s Event may be canceled, at any time, if the USSR removes 2 Influence from Cuba or the US removes 2 Influence from West Germany or Turkey.",
        title: "Cuban Missile Crisis*",
        url: "http://twilightstrategy.com/2012/09/06/cuban-missile-crisis/"
    ),
    "Nuclear Subs*" => Card.new(
        id: 41,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "US Operations used for Coup Attempts in Battleground countries, for the remainder of this turn, do not degrade the DEFCON level. This card\u2019s Event does not apply to any Event that would affect the DEFCON level (ex. the \u201c#40 \u2013 Cuban Missile Crisis\u201d Event).",
        title: "Nuclear Subs*",
        url: "http://twilightstrategy.com/2012/09/10/nuclear-subs/"
    ),
    "Quagmire*" => Card.new(
        id: 42,
        ongoing: true,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "On the US\u2019s next action round, it must discard an Operations card with a value of 2 or more and roll 1-4 on a die to cancel this Event. Repeat this Event for each US action round until the US successfully rolls 1-4 on a die. If the US is unable to discard an Operations card, it must play all of its scoring cards and then skip each action round for the rest of the turn. This Event cancels the effect(s) of the \u201c#106 \u2013 NORAD\u201d Event (if applicable).",
        title: "Quagmire*",
        url: "http://twilightstrategy.com/2012/09/12/quagmire/"
    ),
    "SALT Negotiations*" => Card.new(
        id: 43,
        ongoing: true,
        ops: 3,
        owner: "neutral",
        removed: true,
        stage: 2,
        text: "Improve the DEFCON level by 2. For the remainder of the turn, both players receive -1 to all Coup Attempt rolls. The player of this card\u2019s Event may look through the discard pile, pick any 1 non-scoring card, reveal it to their opponent and then place the drawn card into their hand.",
        title: "SALT Negotiations*",
        url: "http://twilightstrategy.com/2012/09/17/salt-negotiations/"
    ),
    "Bear Trap*" => Card.new(
        id: 44,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 2,
        text: "On the USSR\u2019s next action round, it must discard an Operations card with a value of 2 or more and roll 1-4 on a die to cancel this Event. Repeat this Event for each USSR action round until the USSR successfully rolls 1-4 on a die. If the USSR is unable to discard an Operations card, it must play all of its scoring cards and then skip each action round for the rest of the turn.",
        title: "Bear Trap*",
        url: "http://twilightstrategy.com/2012/09/19/bear-trap/"
    ),
    "Summit" => Card.new(
        id: 45,
        ongoing: false,
        ops: 1,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Both players roll a die. Each player receives +1 to the die roll for each Region (Europe, Asia, etc.) they Dominate or Control. The player with the highest modified die roll receives 2 VP and may degrade or improve the DEFCON level by 1 (do not reroll ties).",
        title: "Summit",
        url: "http://twilightstrategy.com/2012/09/24/summit/"
    ),
    "How I Learned to Stop Worrying*" => Card.new(
        id: 46,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: true,
        stage: 2,
        text: "Set the DEFCON level to any level desired (1-5). The player adds 5 to its Military Operations Track.",
        title: "How I Learned to Stop Worrying*",
        url: "http://twilightstrategy.com/2012/09/26/how-i-learned-to-stop-worrying/"
    ),
    "Junta" => Card.new(
        id: 47,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Add 2 Influence to a single country in Central or South America. The player may make free Coup Attempts or Realignment rolls in either Central or South America using the Operations value of this card.",
        title: "Junta",
        url: "http://twilightstrategy.com/2012/10/01/junta/"
    ),
    "Kitchen Debates*" => Card.new(
        id: 48,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 2,
        text: "If the US controls more Battleground countries than the USSR, the US player uses this Event to poke their opponent in the chest and receive 2 VP!",
        title: "Kitchen Debates*",
        url: "http://twilightstrategy.com/2012/10/03/kitchen-debates/"
    ),
    "Missile Envy" => Card.new(
        id: 49,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Exchange this card for your opponent\u2019s highest value Operations card. If 2 or more cards are tied, opponent chooses. If the exchanged card contains an Event applicable to yourself or both players, it occurs immediately. If it contains an opponent\u2019s Event, use the Operations value (no Event). The opponent must use this card for Operations during their next action round.",
        title: "Missile Envy",
        url: "http://twilightstrategy.com/2012/10/08/missile-envy/"
    ),
    "We Will Bury You*" => Card.new(
        id: 50,
        ongoing: false,
        ops: 4,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "Degrade the DEFCON level by 1. Unless the #32 UN Intervention card is played as an Event on the US\u2019s next action round, the USSR receives 3 VP.",
        title: "We Will Bury You*",
        url: "http://twilightstrategy.com/2012/10/10/we-will-bury-you/"
    ),
    "Brezhnev Doctrine*" => Card.new(
        id: 51,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "All Operations cards played by the USSR, for the remainder of this turn, receive +1 to their Operations value (to a maximum of 4 Operations per card).",
        title: "Brezhnev Doctrine*",
        url: "http://twilightstrategy.com/2012/10/12/brezhnev-doctrine/"
    ),
    "Portuguese Empire Crumbles*" => Card.new(
        id: 52,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "Add 2 USSR Influence to Angola and the SE African States.",
        title: "Portuguese Empire Crumbles*",
        url: "http://twilightstrategy.com/2012/10/15/portuguese-empire-crumbles/"
    ),
    "South African Unrest" => Card.new(
        id: 53,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 2,
        text: "The USSR either adds 2 Influence to South Africa or adds 1 Influence to South Africa and 2 Influence to a single country adjacent to South Africa.",
        title: "South African Unrest",
        url: "http://twilightstrategy.com/2012/10/16/south-african-unrest/"
    ),
    "Allende*" => Card.new(
        id: 54,
        ongoing: false,
        ops: 1,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "Add 2 USSR Influence to Chile.",
        title: "Allende*",
        url: "http://twilightstrategy.com/2012/10/17/allende/"
    ),
    "Willy Brandt*" => Card.new(
        "affects": 21,
        "antireq": 96,
        id: 55,
        ongoing: true,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "The USSR receives 1 VP and adds 1 Influence to West Germany. This Event cancels the effect(s) of the \u201c#21 \u2013 NATO\u201d Event for West Germany only. This Event is prevented / canceled by the \u201c#96 \u2013 Tear Down this Wall\u201d Event.",
        title: "Willy Brandt*",
        url: "http://twilightstrategy.com/2012/10/18/willy-brandt/"
    ),
    "Muslim Revolution" => Card.new(
        id: 56,
        ongoing: false,
        ops: 4,
        owner: "ussr",
        removed: false,
        stage: 2,
        text: "Remove all US Influence from 2 of the following countries: Sudan, Iran, Iraq, Egypt, Libya, Saudi Arabia, Syria, Jordan. This Event cannot be used after the \u201c#110 \u2013 AWACS Sale to Saudis\u201d Event has been played.",
        title: "Muslim Revolution",
        url: "http://twilightstrategy.com/2012/10/19/muslim-revolution/"
    ),
    "ABM Treaty" => Card.new(
        id: 57,
        ongoing: false,
        ops: 4,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Improve the DEFCON level by 1 and then conduct Operations using the Operations value of this card.",
        title: "ABM Treaty",
        url: "http://twilightstrategy.com/2012/10/23/abm-treaty/"
    ),
    "Cultural Revolution*" => Card.new(
        id: 58,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "If the US has the \u201c#6 \u2013 The China Card\u201d card, the US must give the card to the USSR (face up and available to be played). If the USSR already has \u201c#6 \u2013 The China Card\u201d card, the USSR receives 1 VP.",
        title: "Cultural Revolution*",
        url: "http://twilightstrategy.com/2012/10/24/cultural-revolution/"
    ),
    "Flower Power*" => Card.new(
        "antireq": 97,
        id: 59,
        ongoing: true,
        ops: 4,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "The USSR receives 2 VP for every US played \u201cWar\u201d card (Arab-Israeli War, Korean War, Brush War, Indo-Pakistani War, Iran-Iraq War), used for Operations or an Event, after this card is played. This Event is prevented / canceled by the \u201c#97 \u2013 An Evil Empire\u201d Event.",
        title: "Flower Power*",
        url: "http://twilightstrategy.com/2012/10/25/flower-power/"
    ),
    "U2 Incident*" => Card.new(
        id: 60,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        "related": 32,
        removed: true,
        stage: 2,
        text: "The USSR receives 1 VP. If the \u201c#32 \u2013 UN Intervention\u201d Event is played later this turn, either by the US or the USSR, the USSR receives an additional 1 VP.",
        title: "U2 Incident*",
        url: "http://twilightstrategy.com/2012/10/26/u-2-incident/"
    ),
    "OPEC" => Card.new(
        "antireq": 86,
        id: 61,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: false,
        stage: 2,
        text: "The USSR receives 1 VP for Control of each of the following countries: Egypt, Iran, Libya, Saudi Arabia, Iraq, Gulf States, Venezuela. This Event cannot be used after the \u201c#86 \u2013 North Sea Oil\u201d Event has been played.",
        title: "OPEC",
        url: "http://twilightstrategy.com/2012/10/29/opec/"
    ),
    "Lone Gunman*" => Card.new(
        id: 62,
        ongoing: false,
        ops: 1,
        owner: "ussr",
        removed: true,
        stage: 2,
        text: "The US reveals their hand of cards. The USSR may use the Operations value of this card to conduct Operations.",
        title: "Lone Gunman*",
        url: "http://twilightstrategy.com/2012/10/30/lone-gunman/"
    ),
    "Colonial Rear Guards" => Card.new(
        id: 63,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: false,
        stage: 2,
        text: "Add 1 US Influence to each of any 4 countries in Africa and/or Southeast Asia.",
        title: "Colonial Rear Guards",
        url: "http://twilightstrategy.com/2012/11/01/colonial-rear-guards/"
    ),
    "Panama Canal Returned*" => Card.new(
        id: 64,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 2,
        text: "Add 1 US Influence to Panama, Costa Rica and Venezuela.",
        title: "Panama Canal Returned*",
        url: "http://twilightstrategy.com/2012/11/02/panama-canal-returned/"
    ),
    "Camp David Accords*" => Card.new(
        id: 65,
        ongoing: true,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "The US receives 1 VP and adds 1 Influence to Israel, Jordan and Egypt. This Event prevents the \u201c#13 \u2013 Arab-Israeli War\u201d card from being played as an Event.",
        title: "Camp David Accords*",
        url: "http://twilightstrategy.com/2012/11/05/camp-david-accords/"
    ),
    "Puppet Governments*" => Card.new(
        id: 66,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "The US may add 1 Influence to 3 countries that do not contain Influence from either the US or USSR.",
        title: "Puppet Governments*",
        url: "http://twilightstrategy.com/2012/11/06/puppet-governments/"
    ),
    "Grain Sales to Soviets" => Card.new(
        id: 67,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: false,
        stage: 2,
        text: "The US randomly selects 1 card from the USSR\u2019s hand (if available). The US must either play the card or return it to the USSR. If the card is returned, or the USSR has no cards, the US may use the Operations value of this card to conduct Operations.",
        title: "Grain Sales to Soviets",
        url: "http://twilightstrategy.com/2012/11/07/grain-sales-to-soviets/"
    ),
    "John Paul II Elected Pope*" => Card.new(
        id: 68,
        ongoing: true,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "Remove 2 USSR Influence from Poland and add 1 US Influence to Poland. This Event allows the \u201c#101 \u2013 Solidarity\u201d card to be played as an Event.",
        title: "John Paul II Elected Pope*",
        url: "http://twilightstrategy.com/2012/11/08/john-paul-ii-elected-pope/"
    ),
    "Latin American Death Squads" => Card.new(
        id: 69,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "All of the phasing player\u2019s Coup Attempts in Central and South America, for the remainder of this turn, receive +1 to their die roll. All of the opponent\u2019s Coup Attempts in Central and South America, for the remainder of this turn, receive -1 to their die roll.",
        title: "Latin American Death Squads",
        url: "http://twilightstrategy.com/2012/11/09/latin-american-death-squads/"
    ),
    "OAS Founded*" => Card.new(
        id: 70,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 2,
        text: "Add a total of 2 US Influence to any countries in Central or South America.",
        title: "OAS Founded*",
        url: "http://twilightstrategy.com/2012/11/12/oas-founded/"
    ),
    "Nixon Plays the China Card*" => Card.new(
        id: 71,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "If the USSR has the \u201c#6 \u2013 The China Card\u201d card, the USSR must give the card to the US (face down and unavailable for immediate play). If the US already has the \u201c#6 \u2013 The China Card\u201d card, the US receives 2 VP.",
        title: "Nixon Plays the China Card*",
        url: "http://twilightstrategy.com/2012/11/13/nixon-plays-the-china-card/"
    ),
    "Sadat Expels Soviets*" => Card.new(
        id: 72,
        ongoing: false,
        ops: 1,
        owner: "us",
        removed: true,
        stage: 2,
        text: "Remove all USSR Influence from Egypt and add 1 US Influence to Egypt.",
        title: "Sadat Expels Soviets*",
        url: "http://twilightstrategy.com/2012/11/14/sadat-expels-soviets/"
    ),
    "Shuttle Diplomacy" => Card.new(
        id: 73,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: false,
        stage: 2,
        text: "If this card\u2019s Event is in effect, subtract (-1) a Battleground country from the USSR total and then discard this card during the next scoring of the Middle East or Asia (which ever comes first).",
        title: "Shuttle Diplomacy",
        url: "http://twilightstrategy.com/2012/11/15/shuttle-diplomacy/"
    ),
    "The Voice of America" => Card.new(
        id: 74,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: false,
        stage: 2,
        text: "Remove 4 USSR Influence from any countries NOT in Europe (removing no more than 2 Influence per country).",
        title: "The Voice of America",
        url: "http://twilightstrategy.com/2012/11/16/the-voice-of-america/"
    ),
    "Liberation Theology" => Card.new(
        id: 75,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 2,
        text: "Add a total of 3 USSR Influence to any countries in Central America (adding no more than 2 Influence per country).",
        title: "Liberation Theology",
        url: "http://twilightstrategy.com/2012/11/19/liberation-theology/"
    ),
    "Ussuri River Skirmish*" => Card.new(
        id: 76,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 2,
        text: "If the USSR has the \u201c#6 \u2013 The China Card\u201d card, the USSR must give the card to the US (face up and available for play). If the US already has the \u201c#6 \u2013 The China Card\u201d card, add a total of 4 US Influence to any countries in Asia (adding no more than 2 Influence per country).",
        title: "Ussuri River Skirmish*",
        url: "http://twilightstrategy.com/2012/11/20/ussuri-river-skirmish/"
    ),
    "Ask Not What Your Country\u2026*" => Card.new(
        id: 77,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 2,
        text: "The US may discard up to their entire hand of cards (including scoring cards) to the discard pile and draw replacements from the draw pile. The number of cards to be discarded must be decided before drawing any replacement cards from the draw pile.",
        title: "Ask Not What Your Country\u2026*",
        url: "http://twilightstrategy.com/2012/11/21/ask-not-what-your-country-can-do-for-you/"
    ),
    "Alliance for Progress*" => Card.new(
        id: 78,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 2,
        text: "The US receives 1 VP for each US controlled Battleground country in Central and South America.",
        title: "Alliance for Progress*",
        url: "http://twilightstrategy.com/2012/11/23/alliance-for-progress/"
    ),
    "Africa Scoring" => Card.new(
        id: 79,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Presence: 1; Domination: 4; Control: 6; +1 VP per controlled Battleground country in Region; MAY NOT BE HELD!",
        title: "Africa Scoring",
        url: "http://twilightstrategy.com/2012/04/11/regions-africa/"
    ),
    "One Small Step\u2026" => Card.new(
        id: 80,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "If you are behind on the Space Race Track, the player uses this Event to move their marker 2 spaces forward on the Space Race Track. The player receives VP only from the final space moved into.",
        title: "One Small Step\u2026",
        url: "http://twilightstrategy.com/2012/11/26/one-small-step/"
    ),
    "South America Scoring" => Card.new(
        id: 81,
        ongoing: false,
        ops: 0,
        owner: "neutral",
        removed: false,
        stage: 2,
        text: "Presence: 2; Domination: 5; Control: 6; +1 VP per controlled Battleground country in Region; MAY NOT BE HELD!",
        title: "South America Scoring",
        url: "http://twilightstrategy.com/2012/08/15/regions-south-america/"
    ),
    "Iranian Hostage Crisis*" => Card.new(
        "affects": 92,
        id: 82,
        ongoing: true,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "Remove all US Influence and add 2 USSR Influence to Iran. This card\u2019s Event requires the US to discard 2 cards, instead of 1 card, if the \u201c#92 \u2013 Terrorism\u201d Event is played.",
        title: "Iranian Hostage Crisis*",
        url: "http://twilightstrategy.com/2012/11/30/iranian-hostage-crisis/"
    ),
    "The Iron Lady*" => Card.new(
        "cancels": 83,
        id: 83,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "Add 1 USSR Influence to Argentina and remove all USSR Influence from the United Kingdom. The US receives 1 VP. This Event prevents the \u201c#7 \u2013 Socialist Governments\u201d card from being played as an Event.",
        title: "The Iron Lady*",
        url: "http://twilightstrategy.com/2012/12/03/the-iron-lady/"
    ),
    "Reagan Bombs Libya*" => Card.new(
        id: 84,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 3,
        text: "The US receives 1 VP for every 2 USSR Influence in Libya.",
        title: "Reagan Bombs Libya*",
        url: "http://twilightstrategy.com/2012/12/04/reagan-bombs-libya/"
    ),
    "Star Wars*" => Card.new(
        id: 85,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 3,
        text: "If the US is ahead on the Space Race Track, the US player uses this Event to look through the discard pile, pick any 1 non-scoring card and play it immediately as an Event.",
        title: "Star Wars*",
        url: "http://twilightstrategy.com/2012/12/05/star-wars/"
    ),
    "North Sea Oil*" => Card.new(
        "cancels": 61,
        id: 86,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "The US may play 8 cards (in 8 action rounds) for this turn only. This Event prevents the \u201c#61 \u2013 OPEC\u201d card from being played as an Event.",
        title: "North Sea Oil*",
        url: "http://twilightstrategy.com/2012/12/06/north-sea-oil/"
    ),
    "The Reformer*" => Card.new(
        "affects": 90,
        id: 87,
        ongoing: true,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "Add 4 USSR Influence to Europe (adding no more than 2 Influence per country). If the USSR is ahead of the US in VP, 6 Influence may be added to Europe instead. The USSR may no longer make Coup Attempts in Europe.",
        title: "The Reformer*",
        url: "http://twilightstrategy.com/2012/12/07/the-reformer/"
    ),
    "Marine Barracks Bombing*" => Card.new(
        id: 88,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "Remove all US Influence in Lebanon and remove a total of 2 US Influence from any countries in the Middle East.",
        title: "Marine Barracks Bombing*",
        url: "http://twilightstrategy.com/2012/12/10/marine-barracks-bombing/"
    ),
    "Soviets Shoot Down KAL-007*" => Card.new(
        id: 89,
        ongoing: false,
        ops: 4,
        owner: "us",
        removed: true,
        stage: 3,
        text: "Degrade the DEFCON level by 1 and the US receives 2 VP. The US may place influence or make Realignment rolls, using this card, if South Korea is US controlled.",
        title: "Soviets Shoot Down KAL-007*",
        url: "http://twilightstrategy.com/2012/12/11/soviets-shoot-down-kal-007/"
    ),
    "Glasnost*" => Card.new(
        id: 90,
        ongoing: false,
        ops: 4,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "Improve the DEFCON level by 1 and the USSR receives 2 VP. The USSR may make Realignment rolls or add Influence, using this card, if the \u201c#87 \u2013 The Reformer\u201d Event has already been played.",
        title: "Glasnost*",
        url: "http://twilightstrategy.com/2012/12/12/glasnost/"
    ),
    "Ortega Elected in Nicaragua*" => Card.new(
        id: 91,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "Remove all US Influence from Nicaragua. The USSR may make a free Coup Attempt, using this card\u2019s Operations value, in a country adjacent to Nicaragua.",
        title: "Ortega Elected in Nicaragua*",
        url: "http://twilightstrategy.com/2012/12/13/ortega-elected-in-nicaragua/"
    ),
    "Terrorism" => Card.new(
        id: 92,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: false,
        stage: 3,
        text: "The player\u2019s opponent must randomly discard 1 card from their hand. If the \u201c#82 \u2013 Iranian Hostage Crisis\u201d Event has already been played, a US player (if applicable) must randomly discard 2 cards from their hand.",
        title: "Terrorism",
        url: "http://twilightstrategy.com/2012/12/14/terrorism/"
    ),
    "Iran-Contra Scandal*" => Card.new(
        id: 93,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "All US Realignment rolls, for the remainder of this turn, receive -1 to their die roll.",
        title: "Iran-Contra Scandal*",
        url: "http://twilightstrategy.com/2012/12/17/iran-contra-scandal/"
    ),
    "Chernobyl*" => Card.new(
        id: 94,
        ongoing: false,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "The US must designate a single Region (Europe, Asia, etc.) that, for the remainder of the turn, the USSR cannot add Influence to using Operations points.",
        title: "Chernobyl*",
        url: "http://twilightstrategy.com/2012/12/18/chernobyl/"
    ),
    "Latin American Debt Crisis" => Card.new(
        id: 95,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 3,
        text: "The US must immediately discard a card with an Operations value of 3 or more or the USSR may double the amount of USSR Influence in 2 countries in South America.",
        title: "Latin American Debt Crisis",
        url: "http://twilightstrategy.com/2012/12/19/latin-american-debt-crisis/"
    ),
    "Tear Down this Wall*" => Card.new(
        "cancels": 55,
        id: 96,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "Add 3 US Influence to East Germany. The US may make free Coup Attempts or Realignment rolls in Europe using the Operations value of this card. This Event prevents / cancels the effect(s) of the \u201c#55 \u2013 Willy Brandt\u201d Event.",
        title: "Tear Down this Wall*",
        url: "http://twilightstrategy.com/2012/12/20/tear-down-this-wall/"
    ),
    "An Evil Empire*" => Card.new(
        "cancels": 59,
        id: 97,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "The US receives 1 VP. This Event prevents / cancels the effect(s) of the \u201c#59 \u2013 Flower Power\u201d Event.",
        title: "An Evil Empire*",
        url: "http://twilightstrategy.com/2012/12/21/an-evil-empire/"
    ),
    "Aldrich Ames Remix*" => Card.new(
        id: 98,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "The US reveals their hand of cards, face-up, for the remainder of the turn and the USSR discards a card from the US hand.",
        title: "Aldrich Ames Remix*",
        url: "http://twilightstrategy.com/2013/01/03/aldrich-ames-remix/"
    ),
    "Pershing II Deployed*" => Card.new(
        id: 99,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "The USSR receives 1 VP. Remove 1 US Influence from any 3 countries in Western Europe.",
        title: "Pershing II Deployed*",
        url: "http://twilightstrategy.com/2013/01/04/pershing-ii-deployed/"
    ),
    "Wargames*" => Card.new(
        id: 100,
        ongoing: false,
        ops: 4,
        owner: "neutral",
        removed: true,
        stage: 3,
        text: "If the DEFCON level is 2, the player may immediately end the game after giving their opponent 6 VP. How about a nice game of chess?",
        title: "Wargames*",
        url: "http://twilightstrategy.com/2013/01/07/wargames/"
    ),
    "Solidarity*" => Card.new(
        id: 101,
        ongoing: false,
        ops: 2,
        owner: "us",
        "prereq": 68,
        removed: true,
        stage: 3,
        text: "Add 3 US Influence to Poland. This card requires prior play of the \u201c#68 \u2013 John Paul II Elected Pope\u201d Event in order to be played as an Event.",
        title: "Solidarity*",
        url: "http://twilightstrategy.com/2013/01/08/solidarity/"
    ),
    "Iran-Iraq War*" => Card.new(
        "affects": 59,
        id: 102,
        ongoing: false,
        ops: 2,
        owner: "neutral",
        removed: true,
        stage: 3,
        text: "Iran invades Iraq or vice versa (player\u2019s choice). Roll a die and subtract (-1) from the die roll for every enemy controlled country adjacent to the target of the invasion (Iran or Iraq). On a modified die roll of 4-6, the player receives 2 VP and replaces all the opponent\u2019s Influence in the target country with their Influence. The player adds 2 to its Military Operations Track.",
        title: "Iran-Iraq War*",
        url: "http://twilightstrategy.com/2013/01/09/iran-iraq-war/"
    ),
    "Defectors" => Card.new(
        id: 103,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: false,
        stage: 1,
        text: "The US may play this card during the Headline Phase in order to cancel the USSR Headline Event (including a scoring card). The canceled card is placed into the discard pile. If this card is played by the USSR during its action round, the US gains 1 VP.",
        title: "Defectors",
        url: "http://twilightstrategy.com/2012/07/09/defectors/"
    ),
    "The Cambridge Five" => Card.new(
        id: 104,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: false,
        stage: 1,
        text: "The US reveals all scoring cards in their hand of cards. The USSR player may add 1 USSR Influence to a single Region named on one of the revealed scoring cards. This card can not be played as an Event during the Late War.",
        title: "The Cambridge Five",
        url: "http://twilightstrategy.com/2012/07/11/the-cambridge-five/"
    ),
    "Special Relationship" => Card.new(
        id: 105,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: false,
        stage: 1,
        text: "Add 1 US Influence to a single country adjacent to the U.K. if the U.K. is US-controlled but NATO is not in effect. Add 2 US Influence to a single country in Western Europe, and the US gains 2 VP, if the U.K. is US-controlled and NATO is in effect.",
        title: "Special Relationship",
        url: "http://twilightstrategy.com/2012/07/18/special-relationship/"
    ),
    "NORAD*" => Card.new(
        "antireq": 42,
        id: 106,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 1,
        text: "Add 1 US Influence to a single country containing US Influence, at the end of each Action Round, if Canada is US-controlled and the DEFCON level moved to 2 during that Action Round. This Event is canceled by the \u201c#42 \u2013 Quagmire\u201d Event.",
        title: "NORAD*",
        url: "http://twilightstrategy.com/2012/07/25/norad/"
    ),
    "Che" => Card.new(
        id: 107,
        ongoing: false,
        ops: 3,
        owner: "ussr",
        removed: false,
        stage: 2,
        text: "The USSR may perform a Coup Attempt, using this card\u2019s Operations value, against a non-Battleground country in Central America, South America or Africa. The USSR may perform a second Coup Attempt, against a different non-Battleground country in Central America, South America or Africa, if the first Coup Attempt removed any US Influence from the target country.",
        title: "Che",
        url: "http://twilightstrategy.com/2012/11/27/che/"
    ),
    "Our Man in Tehran*" => Card.new(
        id: 108,
        ongoing: false,
        ops: 2,
        owner: "us",
        removed: true,
        stage: 2,
        text: "If the US controls at least one Middle East country, the US player uses this Event to draw the top 5 cards from the draw pile. The US may discard any or all of the drawn cards, after revealing the discarded card(s) to the USSR player, without triggering the Event(s). Any remaining drawn cards are returned to the draw pile and the draw pile is reshuffled.",
        title: "Our Man in Tehran*",
        url: "http://twilightstrategy.com/2012/11/28/our-man-in-tehran/"
    ),
    "Yuri and Samantha*" => Card.new(
        id: 109,
        ongoing: false,
        ops: 2,
        owner: "ussr",
        removed: true,
        stage: 3,
        text: "The USSR receives 1 VP for each US Coup Attempt performed during the remainder of the Turn.",
        title: "Yuri and Samantha*",
        url: "http://twilightstrategy.com/2013/01/10/yuri-and-samantha/"
    ),
    "AWACS Sale to Saudis*" => Card.new(
        id: 110,
        ongoing: true,
        ops: 3,
        owner: "us",
        removed: true,
        stage: 3,
        text: "Add 2 US Influence to Saudi Arabia. This Event prevents the \u201c#56 \u2013 Muslim Revolution\u201d card from being played as an Event.",
        title: "AWACS Sale to Saudis*",
        url: "http://twilightstrategy.com/2013/01/14/awacs-sale-to-saudis/"
    )
}
end
