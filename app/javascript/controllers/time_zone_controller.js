import { Controller } from "@hotwired/stimulus"
import jstz from "jstimezonedetect"

// Connects to data-controller="time-zone"
export default class extends Controller {
  static targets = ["timeZoneField"]

  connect() {
    var tz = jstz.determine();
    var timeZone = tz.name();
    this.timeZoneFieldTarget.value = timeZone;
  }
}