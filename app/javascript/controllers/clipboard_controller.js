import Clipboard from '@stimulus-components/clipboard'
// Connects to data-controller="clipboard"
export default class extends Clipboard {
  copy(event) {
    super.copy(event);
    event.target.classList.add("btn--success")

    setTimeout(() => {
      event.target.classList.remove("btn--success")
    },2000);
  }
}
