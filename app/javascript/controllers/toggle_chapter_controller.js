import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

// Connects to data-controller="toggle-chapter"
export default class extends Controller {
  static values = { url: String };

  handleClick() {
    post(this.urlValue, {
      responseKind: "turbo-stream",
    });
  }
}
