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

function addMaskedCard(cardId, pile) {
  let dest = document.getElementById(pile);
  let cards = dest.getElementsByClassName("cards")[0];
  let cardHtml = buildMaskedCardElement(cardId, pile);

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

function removeCard(cardId, pile) {
  let cardElement = document.getElementById(cardId);

  cardElement.parentElement.removeChild(cardElement);
}

function addPotentiallyMaskedCard(card, cardId, pile) {
  if (card !== null && card !== undefined)
    addCard(card, pile);
  else
    addMaskedCard(cardId, pile);
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

function buildMaskedCardElement(cardId, pile) {
  // <li class="masked-card" id="<%= masked_card.id %>" draggable="true">
  //   <%= form.radio_button :source, "#{masked_card.id}-in-#{pile}" %>
  //   <%= form.label :source, value: "#{masked_card.id}-in-#{pile}" do %>
  //     Unknown card
  //   <% end %>
  // </li>

  let li = document.createElement("li");
  li.setAttribute("class", "masked-card");
  li.setAttribute("id", cardId);
  li.setAttribute("draggable", "true")

  let radio = document.createElement("input");
  radio.setAttribute("id","card_movement_source_" + cardId + "-in-" + pile);
  radio.setAttribute("type", "radio");
  radio.setAttribute("value", cardId + "-in-" + pile);
  radio.setAttribute("name", "card_movement[source]");
  radio.hidden = true;

  let label = document.createElement("label");
  label.setAttribute("for", radio.getAttribute("id"));
  label.setAttribute("class", "card__details");
  label.appendChild(document.createTextNode("Unknown card"));

  li.appendChild(radio);
  li.appendChild(label);

  return li;
}

function buildCardElement(card, pile) {
  // <li class="card card__<%= card.type %>"" id="<%= card.id %>" draggable="true">
  //   <%= form.radio_button :source, "#{card.id}-in-#{pile}" %>
  //   <%= form.label :source, value: "#{card.id}-in-#{pile}", class: "card__details" do %>
  //     <span class="card__name"><%= card.name %></span>
  //     <span class="card__image"><img src="https://placekitten.com/175/175"></span>
  //     <span class="card__type" title="<%= card.type %>"></span>
  //     <span class="card__charge"><%= card.charge %></span>
  //     <span class="card__ability"><%= card.ability %></span>
  //   <% end %>
  // </li>

  let li = document.createElement("li");
  li.setAttribute("class", "card card__" + card.type);
  li.setAttribute("id", card.id);
  li.setAttribute("draggable", "true")

  let radio = document.createElement("input");
  radio.setAttribute("id","card_movement_source_" + card.id + "-in-" + pile);
  radio.setAttribute("type", "radio");
  radio.setAttribute("value", card.id + "-in-" + pile);
  radio.setAttribute("name", "card_movement[source]");
  radio.hidden = true;

  let label = document.createElement("label");
  label.setAttribute("for", radio.getAttribute("id"));
  label.setAttribute("class", "card__details");

  let cardName = document.createElement("span");
  cardName.setAttribute("class", "card__name");
  cardName.appendChild(document.createTextNode(card.name));

  let image = document.createElement("img");
  image.setAttribute("src", "https://placekitten.com/175/175");

  let cardImage = document.createElement("span");
  cardImage.setAttribute("class", "card__image");
  cardImage.appendChild(image);

  let cardType = document.createElement("span");
  cardType.setAttribute("class", "card__type");
  cardType.setAttribute("title", card.type);

  let cardCharge = document.createElement("span");
  cardCharge.setAttribute("class", "card__charge");
  cardCharge.appendChild(document.createTextNode(card.charge));

  let cardAbility = document.createElement("span");
  cardAbility.setAttribute("class", "card__ability");
  cardAbility.appendChild(document.createTextNode(card.ability));

  label.appendChild(cardName);
  label.appendChild(cardImage);
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
        removeCard(data["extra"]["source_card_id"], data["source_pile"]);
        addPotentiallyMaskedCard(
            data["source_card"],
            data["extra"]["source_card_id"],
            data["dest_pile"]
        );
        break;
      case "board":
        removeCard(data["source_card"].id, data["source_pile"]);
        addCard(data["source_card"], data["dest_pile"]);
        break;
      case "discard":
        removeCard(data["source_card"].id, data["source_pile"]);
        setDiscard(data["source_card"]);
        break;
      }
      break;
    case "deck":
      switch (data["dest_pile_type"]) {
      case "hand":
        removeFromDeck(data["extra"]["new_top_card_id"]);
        addPotentiallyMaskedCard(
            data["source_card"],
            data["extra"]["source_card_id"],
            data["dest_pile"]
        );
        break;
      }
      break;
    case "discard":
      switch (data["dest_pile_type"]) {
      case "hand":
        setDiscard(data["extra"]["discard"]);
        addPotentiallyMaskedCard(
            data["source_card"],
            data["extra"]["source_card_id"],
            data["dest_pile"]
        );
        break;
      }
      break;
    case "hand":
      switch (data["dest_pile_type"]) {
      case "board":
        removeMaskedCard(data["extra"]["source_card_id"]);
        addCard(data["source_card"], data["dest_pile"]);
        break;
      case "deck": // pile-deck, pile-deck-bottom
        removeMaskedCard(data["extra"]["source_card_id"]);
        addToDeck(data["extra"]["new_top_card_id"]);
        break;
      case "discard":
        removeMaskedCard(data["extra"]["source_card_id"]);
        setDiscard(data["extra"]["discard"]);
        break;
      }
    }
  },
});
