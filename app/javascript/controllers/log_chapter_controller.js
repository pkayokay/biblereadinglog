import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="log-chapter"
export default class extends Controller {
  static values = { opened: Boolean };

  toggle(event) {
    if (event.target.openedValue === true) {
      event.preventDefault();
      const chapterContainer = document.querySelector(`[data-chapter-container-id="${event.target.dataset.turboFrame}"]`)

      if (chapterContainer.classList.contains("!hidden")) {
        event.target.innerText = "Close"
      } else {
        event.target.innerText = "Log chapter"
      }
      chapterContainer.classList.toggle("!hidden")
    } else {
      event.target.innerText = "Close"
      event.target.openedValue = true
    }
  }
}
