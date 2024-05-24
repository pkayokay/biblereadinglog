import { Dropdown } from "tailwindcss-stimulus-components";

// Connects to data-controller="dropdown"
export default class extends Dropdown {
  hide(event) {
    //github.com/excid3/tailwindcss-stimulus-components/blob/main/src/dropdown.js
    https: super.hide(event);
    // TODO: hide when clicking menu item
  }
}
