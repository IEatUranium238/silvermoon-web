const buttonFwd = document.getElementById("featureFord");
const buttonBk = document.getElementById("featureBack");

let itemsDesc = [];
let itemsCode = [];

let indx = 0;

for (let i = 1; i < 5; i++) {
  itemsDesc.push(document.getElementById("feature" + i));
  itemsCode.push(document.getElementById("code" + i));
}

function setVis(isFwd) {
  itemsDesc[indx].classList.add("hidden");
  itemsCode[indx].classList.add("hidden");

  indx = isFwd ? indx + 1 : indx - 1;

  if (indx === 0) {
    buttonBk.classList.add("hidden");
  } else {
    buttonBk.classList.remove("hidden");
  }

  if (indx === 3) {  // ← Changed from 4 to 3
    buttonFwd.classList.add("hidden");
  } else {
    buttonFwd.classList.remove("hidden");
  }

  itemsDesc[indx].classList.remove("hidden");
  itemsCode[indx].classList.remove("hidden");
}

buttonBk.addEventListener("click", () => {
  setVis(false);
})

buttonFwd.addEventListener("click", () => {
  setVis(true);
})