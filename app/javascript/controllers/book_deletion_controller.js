import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="book-deletion"
export default class extends Controller {
  delete(e) {
    let confirmed = confirm("Are you sure you want to delete this?");
    if (!confirmed) {
      e.preventDefault();
    }
  }
}
