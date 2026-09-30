const openBtn = document.getElementById("headerBurger");
const closeBtn = document.getElementById("closeMenu");
const menu = document.getElementById("menu");

openBtn.addEventListener("click", () => {
  menu.classList.remove("hidden");
})

closeBtn.addEventListener("click", () => {
  menu.classList.add("hidden");
})