import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    requestAnimationFrame(() => {
      this.element.classList.add("active");
    });

    // setTimeout(() => this.close(), 5000);
  }

  close() {
    this.element.classList.add("leaving");
    this.element.classList.remove("active");
    this.element.addEventListener("transitionend", () => {
      this.element.remove();
    });
  }
}