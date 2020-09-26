import Rails from "@rails/ujs";

/* draggables */

function dragStart(ev) {
  ev.target.classList.add("drag-target");
  ev.dataTransfer.setData("application/x-source-id", ev.target.id);
  ev.dataTransfer.dropEffect = "move";

  const source = findTarget(ev.target);
  const dests = destsForSource(source);

  for (const dest of dests) {
    dest.classList.add("drop-target");
    dest.addEventListener("dragover", dragOver);
    dest.addEventListener("dragenter", dragEnter);
    dest.addEventListener("dragleave", dragLeave);
    dest.addEventListener("drop", drop);
  }
}

function dragEnd(ev) {
  const source = findTarget(ev.target);
  const dests = destsForSource(source);

  for (const dest of dests) {
    dest.classList.remove("drop-target");
    dest.classList.remove("drop-over");
    dest.removeEventListener("drop", drop);
    dest.removeEventListener("dragleave", dragLeave);
    dest.removeEventListener("dragenter", dragEnter);
    dest.removeEventListener("dragover", dragOver);
  }

  ev.target.classList.remove("drag-target");
}

/* droppables */

function dragOver(ev) {
  ev.preventDefault();
}

function dragEnter(ev) {
  const dest = findTarget(ev.target);

  if (dest !== null)
    dest.classList.add("drop-over");
}

function dragLeave(ev) {
  const destWas = findTarget(ev.target);
  const destIs = findTarget(ev.relatedTarget);

  if (destWas !== null && destWas !== destIs)
    destWas.classList.remove("drop-over");
}

function drop(ev) {
  ev.preventDefault();

  const dest = findTarget(ev.target);
  if (dest === null)
    return;

  const data = ev.dataTransfer.getData("application/x-source-id");
  const source = document.getElementById(data);
  if (source === null)
    return;

  for (const e of [dest, source]) {
    e.getElementsByTagName("input")[0].checked = true;
  }

  Rails.fire(document.getElementById("new_card_movement"), "submit");
}

/* helpers */

function destsForSource(source) {
  let result = [];

  if (source.classList.contains("pile__hand")) {
    result = [
      ...document.getElementsByClassName("pile__board"),
      document.getElementById("pile-deck"),
      document.getElementById("pile-discard")
    ];
  } else if (source.classList.contains("pile__board")) {
    result = [
      ...document.getElementsByClassName("pile__hand"),
      ...document.getElementsByClassName("pile__board"),
      document.getElementById("pile-discard")
    ];
  } else if (source.classList.contains("pile__deck")) {
    result = [...document.getElementsByClassName("pile__hand")];
  } else if (source.classList.contains("pile__discard")) {
    result = [...document.getElementsByClassName("pile__hand")];
  } else {
    result = [];
  }

  return result.filter(e => e !== source);
}

function findTarget(t) {
  while (
      t !== null &&
      t.tagName !== "SECTION" &&
      t.tagName !== "BODY"
  ) {
    t = t.parentNode;
  }

  if (t !== null && t.tagName === "SECTION")
    return t;
  else
    return null;
}

function connectDragables() {
  document.addEventListener("dragstart", dragStart);
  document.addEventListener("dragend", dragEnd);
}

function hideFormWidgets() {
  const inputs = document.getElementsByTagName("input");

  for (const element of inputs) {
    element.hidden = true;
  }
}

/* main */

window.addEventListener('DOMContentLoaded', () => {
  connectDragables();
  hideFormWidgets();
});
