import consumer from "./consumer"

function addToDeck(cardId) {
  let deckPile = document.getElementById("pile-deck-top");
  let deckSize = document.getElementById("pile-deck-size");
  let deckInt = parseInt(deckSize.textContent);
  let radio = deckPile.getElementsByTagName("input")[0];
  let label = deckPile.getElementsByTagName("label")[0];

  if (deckInt === NaN) {
    deckSize.textContent = 1;
  } else {
    deckSize.textContent = deckInt + 1;
  }

  radio.setAttribute("id", "card_movement_source_" + cardId + "-in-pile-deck");
  radio.setAttribute("value", cardId + "-in-pile-deck");
  label.setAttribute("for", radio.getAttribute("id"));
}

function removeFromDeck(newTopCardId) {
  let deckPile = document.getElementById("pile-deck-top");
  let deckSize = document.getElementById("pile-deck-size");
  let deckInt = parseInt(deckSize.textContent);
  let radio = deckPile.getElementsByTagName("input")[0];
  let label = deckPile.getElementsByTagName("label")[0];

  if (deckInt != NaN && deckInt > 0) {
    deckSize.textContent = (deckInt - 1);
  }

  radio.setAttribute("id", "card_movement_source_" + newTopCardId + "-in-pile-deck");
  radio.setAttribute("value", newTopCardId + "-in-pile-deck");
  label.setAttribute("for", radio.getAttribute("id"));
}

function addMaskedCard(pile) {
  let dest = document.getElementById(pile);
  let cards = dest.getElementsByClassName("cards")[0];
  let cardHtml = buildMaskedCardElement(card, pile);

  cards.appendChild(cardHtml);
}

function removeMaskedCard(cardId) {
  let cardElement = document.getElementById(cardId);

  cardElement.parentElement.removeChild(cardElement);
}

function addCard(card, pile) {
  let dest = document.getElementById(pile);
  let cards = dest.getElementsByClassName("cards")[0];
  let cardHtml = buildCardElement(card, pile);

  cards.appendChild(cardHtml);
}

function removeCard(card, pile) {
  let cardElement = document.getElementById(card.id);

  cardElement.parentElement.removeChild(cardElement);
}

function setDiscard(card) {
  let discardPile = document.getElementById("pile-discard");
  let cards = discardPile.getElementsByClassName("cards")[0];

  if (card == null) {
    debugger;
  } else {
    let cardHtml = buildCardElement(card, "pile-discard");

    while (cards.firstChild) {
      cards.removeChild(cards.firstChild);
    }
    cards.appendChild(cardHtml);
  }
}

function buildCardElement(card, pile) {
  // <li class="card" id="<%= card.id %>">
  //   <%= form.radio_button :source, "#{card.id}-in-#{pile}" %>
  //   <%= form.label :source, value: "#{card.id}-in-#{pile}" do %>
  //     <span class="card__name"><%= card.name %></span>
  //     <span class="card__type"><%= card.type %></span>
  //     <span class="card__charge"><%= card.charge %></span>
  //     <span class="card__ability"><%= card.ability %></span>
  //   <% end %>
  // </li>

  let li = document.createElement("li");
  li.setAttribute("class", "card");
  li.setAttribute("id", card.id);

  let radio = document.createElement("input");
  radio.setAttribute("id","card_movement_source_" + card.id + "-in-" + pile);
  radio.setAttribute("type", "radio");
  radio.setAttribute("value", card.id + "-in-" + pile);
  radio.setAttribute("name", "card_movement[source]");

  let label = document.createElement("label");
  label.setAttribute("for", radio.getAttribute("id"));

  let cardName = document.createElement("span");
  cardName.setAttribute("class", "card__name");
  cardName.appendChild(document.createTextNode(card.name));

  let cardType = document.createElement("span");
  cardName.setAttribute("class", "card__type");
  cardName.appendChild(document.createTextNode(card.type));

  let cardCharge = document.createElement("span");
  cardName.setAttribute("class", "card__charge");
  cardName.appendChild(document.createTextNode(card.charge));

  let cardAbility = document.createElement("span");
  cardName.setAttribute("class", "card__ability");
  cardName.appendChild(document.createTextNode(card.ability));

  label.appendChild(cardName);
  label.appendChild(cardType);
  label.appendChild(cardCharge);
  label.appendChild(cardAbility);

  li.appendChild(radio);
  li.appendChild(label);

  return li;
}

consumer.subscriptions.create("ActionChannel", {
  connected() { },
  disconnected() { },

  received(data) {
    switch (data["source_pile_type"]) {
    case "board":
      switch (data["dest_pile_type"]) {
      case "hand":
        removeCard(data["source_card"], data["source_pile"]);
        addMaskedCard(data["dest_pile"]);
        break;
      case "board":
        removeCard(data["source_card"], data["source_pile"]);
        addCard(data["source_card"], data["dest_pile"]);
        break;
      case "discard":
        removeCard(data["source_card"], data["source_pile"]);
        setDiscard(data["source_card"]);
        break;
      }
      break;
    case "deck":
      switch (data["dest_pile_type"]) {
      case "hand":
        removeFromDeck(data["extra"]["new_top_card_id"]);
        addMaskedCard(data["dest_pile"]);
        break;
      }
      break;
    case "discard":
      switch (data["dest_pile_type"]) {
      case "hand":
        setDiscard(data["extra"]["discard"]);
        addMaskedCard(data["dest_pile"]);
        break;
      }
      break;
    case "hand":
      switch (data["dest_pile_type"]) {
      case "board":
        removeMaskedCard(data["extra"]["card_id"]);
        addCard(data["source_card"], data["dest_pile"]);
        break;
      case "deck": // pile-deck, pile-deck-bottom
        removeMaskedCard(data["extra"]["card_id"]);
        addToDeck(data["extra"]["new_top_card_id"]);
        break;
      case "discard":
        removeMaskedCard(data["extra"]["card_id"]);
        setDiscard(data["extra"]["discard"]);
        break;
      }
    }
  },
});
