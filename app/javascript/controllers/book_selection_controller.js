import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-selection"
export default class extends Controller {
  static targets = ["bookList"];

  connect() {
  }

  toggleCheck(e) {
    console.log(e.target.checked)
    if (e.target.checked) {
      this.bookListTarget.classList.add("hidden")
    } else {
      this.bookListTarget.classList.remove("hidden")
    }
  }
}

