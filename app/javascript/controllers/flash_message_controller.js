import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

// Connects to data-controller="post-flash"
export default class extends Controller {
  send() {
    post("/flash_message", {
      body: {
        message: this.element.dataset.flashMessage,
      },
      responseKind: "turbo-stream",
    });
  }
}
