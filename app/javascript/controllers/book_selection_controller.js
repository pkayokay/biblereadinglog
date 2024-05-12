import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-selection"
export default class extends Controller {
  static targets = ["bookList"];

  toggleRadio(e) {
    if (e.target.value === "true") {
      this.bookListTarget.classList.add("hidden")
    } else {
      this.bookListTarget.classList.remove("hidden")
    }
  }
}

