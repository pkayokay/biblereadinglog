import { Controller } from "@hotwired/stimulus"

const BORDER_COLOR = "border-red-400"
const BG_COLOR = "bg-red-50"
// Connects to data-controller="book-selection"
export default class extends Controller {
  static targets = ["bookList","trueOption", "falseOption"];

  connect() {
    this.trueOptionTarget.classList.add(BG_COLOR)
    this.trueOptionTarget.classList.add(BORDER_COLOR)
  }

  toggleRadio(e) {
    if (e.target.value === "true") {
      this.falseOptionTarget.classList.remove(BG_COLOR)
      this.trueOptionTarget.classList.add(BG_COLOR)
      this.falseOptionTarget.classList.remove(BORDER_COLOR)
      this.trueOptionTarget.classList.add(BORDER_COLOR)
      this.bookListTarget.classList.add("hidden")
    } else {
      this.trueOptionTarget.classList.remove(BG_COLOR)
      this.falseOptionTarget.classList.add(BG_COLOR)
      this.trueOptionTarget.classList.remove(BORDER_COLOR)
      this.falseOptionTarget.classList.add(BORDER_COLOR)
      this.bookListTarget.classList.remove("hidden")
    }
  }
}

