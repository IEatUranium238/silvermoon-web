const folders = document.querySelectorAll(".doc-btn");
const collapse = document.getElementById("sideBtn");

let sidebarOpen = true;

folders.forEach((folder) => {
  folder.addEventListener("click", () => {
    isOpen = folder.classList.contains("open");

    if (isOpen) {
      folder.classList.remove("open");

      const icon = folder.querySelector("i");
      icon.classList.remove("bi-caret-down-fill");
      icon.classList.add("bi-caret-right-fill");

      const folderId = "folder" + folder.id.slice(9);
      const content = document.getElementById(folderId);

      content.classList.add("hidden");
    } else {
      folder.classList.add("open");

      const icon = folder.querySelector("i");
      icon.classList.remove("bi-caret-right-fill");
      icon.classList.add("bi-caret-down-fill");

      const folderId = "folder" + folder.id.slice(9);
      const content = document.getElementById(folderId);

      content.classList.remove("hidden");
    }
  });
});

collapse.addEventListener("click", () => {
  sidebarOpen = !sidebarOpen;
  const sidebar = document.querySelector("aside");
  const content = sidebar.querySelector(".content");
  const title = sidebar.querySelector(".title").querySelector("h2");

  if (!sidebarOpen) {
    sidebar.style.borderColor = "transparent";
    sidebar.style.minWidth = "0";

    content.classList.add("hidden");
    title.classList.add("hidden");
  } else {
    sidebar.removeAttribute("style");

    setTimeout(() => {
      content.classList.remove("hidden");
      title.classList.remove("hidden");
    }, 150);
  }
});
