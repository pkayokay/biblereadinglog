import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cache"
export default class extends Controller {

  connect() {
    Turbo.cache.exemptPageFromCache();
  }
}
