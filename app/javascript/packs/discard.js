import Rails from "@rails/ujs";

function tapToSubmit() {
  const cards = document.getElementsByClassName("card");

  for (const card of cards) {
    card.addEventListener('click', () => {
      const input = card.getElementsByTagName("input");
      input[0].checked = true;
      Rails.fire(document.getElementById("new_card_movement"), "submit");
    });
  }
}

function hideFormWidgets() {
  const inputs = document.getElementsByTagName("input");

  for (const element of inputs) {
    element.hidden = true;
  }
}

window.addEventListener('DOMContentLoaded', () => {
  tapToSubmit();
  hideFormWidgets();
});
