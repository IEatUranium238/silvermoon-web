const buttons = document.querySelectorAll(".change-mode-button");
const html = document.documentElement;
const systemQuery = window.matchMedia("(prefers-color-scheme: dark)");

const savedTheme = localStorage.getItem("theme");
let mode = savedTheme || (systemQuery.matches ? "dark" : "light");

function handleMode() {
  const isDark = mode === "dark";
  html.classList.toggle("dark-mode", isDark);

  buttons.forEach((button) => {
    button.innerHTML = isDark
      ? '<i class="bi bi-sun" aria-hidden="true"></i>'
      : '<i class="bi bi-moon-stars" aria-hidden="true"></i>';
  });
}

handleMode();

buttons.forEach((button) => {
  button.addEventListener("click", () => {
    mode = mode === "light" ? "dark" : "light";
    localStorage.setItem("theme", mode);
    handleMode();
  });
});

systemQuery.addEventListener("change", (e) => {
  if (!localStorage.getItem("theme")) {
    mode = e.matches ? "dark" : "light";
    handleMode();
  }
});
