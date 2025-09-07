import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="time-zone"
export default class extends Controller {
  static targets = ["field"];

  connect() {
    var tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
    if (tz && this.fieldTarget) {
      this.fieldTarget.value = tz;
    }
  }
}
