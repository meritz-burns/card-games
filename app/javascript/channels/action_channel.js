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
  const cardTemplate = document.getElementById("template-masked-card");
  const newCard = cardTemplate.content.firstElementChild.cloneNode(true);

  newCard.setAttribute("id", cardId);

  const radio = newCard.getElementsByTagName("input")[0];
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

  const radio = newCard.getElementsByTagName("input")[0];
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
