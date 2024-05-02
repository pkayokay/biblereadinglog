import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reading-log-index"
export default class extends Controller {
  navigate(e) {
    if (!e.target.href) {
      const row = e.target.closest('[data-url]')
      Turbo.visit(row.dataset.url)
    }
  }
}
