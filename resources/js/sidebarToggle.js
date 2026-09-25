const folders = document.querySelectorAll(".doc-btn");

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
  