document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.getElementById("sidebar");
  const menuToggle = document.getElementById("menuToggle");

  menuToggle.addEventListener("click", () => {
    sidebar.classList.toggle("-translate-x-full");
  });
});
