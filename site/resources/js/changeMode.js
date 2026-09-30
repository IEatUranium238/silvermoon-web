const buttons = document.querySelectorAll(".change-mode-button");
const html = document.documentElement;
let mode = localStorage.getItem("theme") || "light";

function handleMode() {
  localStorage.setItem("theme", mode);
  if (mode === "dark") {
    html.classList.add("dark-mode");

    buttons.forEach((button) => {
      button.innerHTML = '<i class="bi bi-sun" aria-hidden="true"></i>';
    });
  } else {
    html.classList.remove("dark-mode");

    buttons.forEach((button) => {
      button.innerHTML = '<i class="bi bi-moon-stars" aria-hidden="true"></i>';
    });
  }
}

handleMode();

buttons.forEach((button) => {
  button.addEventListener("click", () => {
    mode = mode === "light" ? "dark" : "light";
    handleMode();
  });
});
