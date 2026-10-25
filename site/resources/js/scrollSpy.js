const nav = document.querySelector(".article-headers");

const links = [...nav.querySelectorAll('a[href^="#"]')];

const sections = links
  .map((link) => {
    const id = decodeURIComponent(link.hash.slice(1));
    const section = document.getElementById(id);

    return section ? { link, section } : null;
  })
  .filter(Boolean);

function updateActiveLink() {
  const offset = 120;
  let activeSection = null;

  for (const item of sections) {
    if (item.section.getBoundingClientRect().top <= offset) {
      activeSection = item;
    } else {
      break;
    }
  }

  activeSection ??= sections[0];

  links.forEach((link) => {
    link.classList.remove("active");
    link.removeAttribute("aria-current");
  });

  if (activeSection) {
    activeSection.link.classList.add("active");
    activeSection.link.setAttribute("aria-current", "location");
  }
}

window.addEventListener("scroll", updateActiveLink, {
  passive: true,
});

window.addEventListener("resize", updateActiveLink);
links.forEach((link) => {
  link.addEventListener("click", () => {
    links.forEach((item) => {
      item.classList.remove("active");
      item.removeAttribute("aria-current");
    });

    link.classList.add("active");
    link.setAttribute("aria-current", "location");
  });
});

updateActiveLink();
