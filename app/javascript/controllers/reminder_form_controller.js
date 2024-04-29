import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reminder-form"
export default class extends Controller {
  static targets = ["frequency", "selectField", "selectLabel", "reminderSection"]

  connect() {
    this.updateDaysSelectField()
  }

  updateDaysSelectField() {
    if (this.frequencyTarget.value === "daily") {
      this.selectFieldTarget.setAttribute("multiple", "multiple")
      this.selectFieldTarget.classList.add("select--multiple")
      this.selectLabelTarget.innerText = "Days"
    } else if (["weekly", "monthly"].includes(this.frequencyTarget.value)) {
      this.selectFieldTarget.classList.remove("select--multiple")
      this.selectFieldTarget.removeAttribute("multiple")

      if (this.frequencyTarget.value === "monthly") {
        this.selectLabelTarget.innerText = "Monthly on this day"
      } else {
        this.selectLabelTarget.innerText = "Weekly on this day"
      }

    }
  }

  toggleIsReminderEnabled(e) {
    console.log(e.target.checked)
    if (e.target.checked) {
      this.reminderSectionTarget.classList.remove("hidden")
    } else {
      this.reminderSectionTarget.classList.add("hidden")
    }
  }
}