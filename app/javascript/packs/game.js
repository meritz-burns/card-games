function dragStartHandler(ev) {
  const radio = ev.target.getElementsByTagName("input")[0];

  ev.dataTransfer.setData("application/x-source-id", radio.id);
  ev.dataTransfer.dropEffect = "move";
}

function dragoverHandler(ev) {
  ev.preventDefault();
  ev.dataTransfer.dropEffect = "move"
}

function dropHandler(ev) {
  ev.preventDefault();

  if (ev.dataTransfer === null)
    return;

  let dropSection = ev.target;
  while (
      dropSection !== null &&
      dropSection.tagName !== "SECTION" &&
      dropSection.tagName !== "BODY"
  ) {
    dropSection = dropSection.parentNode;
  }

  if (dropSection.tagName !== "SECTION")
    return;

  const sourceRadioId = ev.dataTransfer.getData("application/x-source-id");

  // get the form elements
  const dropRadio = dropSection.getElementsByClassName("pile-radio")[0];
  const sourceRadio = document.getElementById(sourceRadioId);
  const form = document.getElementById("new_card_movement");

  // set up and submit the form
  dropRadio.checked = true;
  sourceRadio.checked = true;
  form.submit();
}

function hideFormWidgets() {
  const inputs = document.getElementsByTagName("input");

  for (element of inputs) {
    element.hidden = true;
  }
}

window.addEventListener('DOMContentLoaded', () => {
  const cards = document.getElementsByClassName("card");
  const maskedCards = document.getElementsByClassName("masked-card");
  const piles = document.getElementsByClassName("pile");

  for (element of cards) {
    element.addEventListener("dragstart", dragStartHandler);
  }

  for (element of maskedCards) {
    element.addEventListener("dragstart", dragStartHandler);
  }

  document.getElementById("pile-deck-top")
    .addEventListener("dragstart", dragStartHandler);

  for (element of piles) {
    element.addEventListener("drop", dropHandler);
    element.addEventListener("dragover", dragoverHandler);
  }

  hideFormWidgets();
});
