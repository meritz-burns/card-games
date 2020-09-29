import consumer from "./consumer"

function setDeck(cardId, delta) {
  let deckPile = document.getElementById("pile-deck");
  let deckSize = document.getElementById("pile-deck-size");
  let deckInt = parseInt(deckSize.textContent);
  let existingCard = deckPile.getElementsByClassName("masked-card")[0];
  let cards = deckPile.getElementsByClassName("cards")[0];

  if (deckInt === NaN) {
    deckSize.textContent = 1;
  } else {
    deckSize.textContent = deckInt + delta;
  }

  if (existingCard !== undefined) {
    existingCard.remove();
  }

  if (cardId !== null) {
    let newTopCard = buildMaskedCardElement(cardId, "pile-deck");
    cards.appendChild(newTopCard);
  }
}

function addMaskedCard(cardId, pile) {
  let dest = document.getElementById(pile);
  let cards = dest.getElementsByClassName("cards")[0];
  let cardHtml = buildMaskedCardElement(cardId, pile);

  cards.appendChild(cardHtml);
}

function removeMaskedCard(cardId) {
  let cardElement = document.getElementById(cardId);

  cardElement.remove();
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

function setDiscard(card, delta) {
  let discardPile = document.getElementById("pile-discard");
  let discardSize = document.getElementById("pile-discard-size");
  let discardInt = parseInt(discardSize.textContent);
  let existingCard = discardPile.getElementsByClassName("card")[0];
  let cards = discardPile.getElementsByClassName("cards")[0];

  if (discardInt === NaN) {
    discardSize.textContent = 1;
  } else {
    discardSize.textContent = discardInt + delta;
  }

  if (existingCard !== undefined) {
    existingCard.remove();
  }

  if (card !== null) {
    let newTopCard = buildCardElement(card, "pile-discard");
    cards.appendChild(newTopCard);
  }
}

function buildMaskedCardElement(cardId, pile) {
  const cardTemplate = document.getElementById("template-masked-card");
  const newCard = cardTemplate.content.firstElementChild.cloneNode(true);

  newCard.setAttribute("id", cardId);

  const radio = newCard.getElementsByTagName("input")["card_movement[source]"];
  radio.setAttribute("id","card_movement_source_" + cardId + "-in-" + pile);
  radio.setAttribute("value", cardId + "-in-" + pile);
  radio.hidden = true;

  const label = newCard.getElementsByTagName("label")[0];
  label.setAttribute("for", radio.getAttribute("id"));
  label.innerHTML = "Unknown card";

  return newCard;
}

function buildCardElement(card, pile) {
  const cardTemplate = document.getElementById("template-card");
  const newCard = cardTemplate.content.firstElementChild.cloneNode(true);

  newCard.setAttribute("class", "card card__" + card.type);
  newCard.setAttribute("id", card.id);

  const radio = newCard.getElementsByTagName("input")["card_movement[source]"];
  radio.setAttribute("id","card_movement_source_" + card.id + "-in-" + pile);
  radio.setAttribute("value", card.id + "-in-" + pile);
  radio.hidden = true;

  const label = newCard.getElementsByTagName("label")[0];
  label.setAttribute("for", radio.getAttribute("id"));

  const cardName = newCard.getElementsByClassName("card__name")[0];
  cardName.innerHTML = card.name;

  const cardType = newCard.getElementsByClassName("card__type")[0];
  cardType.setAttribute("title", card.type);

  const cardCharge = newCard.getElementsByClassName("card__charge")[0];
  cardCharge.innerHTML = card.charge;

  const cardAbility = newCard.getElementsByClassName("card__ability")[0];
  cardAbility.innerHTML = card.ability;

  return newCard;
}

function matchingLabel(container, input) {
  return Array.
    from(container.getElementsByTagName("label")).
    find(function(l) { return l.getAttribute("for") === input.id });
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
        setDiscard(data["source_card"], +1);
        break;
      }
      break;
    case "deck":
      switch (data["dest_pile_type"]) {
      case "hand":
        setDeck(data["extra"]["new_top_card_id"], -1)
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
        setDiscard(data["extra"]["discard"], -1);
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
        setDeck(data["extra"]["new_top_card_id"], +1);
        break;
      case "discard":
        removeMaskedCard(data["extra"]["source_card_id"]);
        setDiscard(data["extra"]["discard"], +1);
        break;
      }
    }
  },
});
