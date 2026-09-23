const button = document.getElementById("changeModeButton");
const html = document.documentElement;

let mode = localStorage.getItem("theme") || "light";

function handleMode() {
  if (mode === "dark") {
    html.classList.add("dark-mode");
    button.innerHTML = '<i class="bi bi-sun" aria-hidden="true"></i>';
  } else {
    html.classList.remove("dark-mode");
    button.innerHTML = '<i class="bi bi-moon-stars" aria-hidden="true"></i>';
  }
}

localStorage.setItem("theme", mode);
handleMode();

button.addEventListener("click", () => {
  mode = mode === "light" ? "dark" : "light";
  localStorage.setItem("theme", mode);
  handleMode();
});
