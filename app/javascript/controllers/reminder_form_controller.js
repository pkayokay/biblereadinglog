import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reminder-form"
export default class extends Controller {
  static targets = ["frequency", "selectField", "selectLabel", "reminderDaysButtons", "reminderSection"]

  connect() {
    this.updateDaysSelectField()
  }

  updateDaysSelectField() {
    if (this.frequencyTarget.value === "daily") {
      this.reminderDaysButtonsTarget.classList.remove("hidden")
      this.selectFieldTarget.classList.add("hidden")
      this.selectFieldTarget.setAttribute("multiple", "multiple")
      this.selectLabelTarget.innerText = "Days"
    } else if (["weekly", "monthly"].includes(this.frequencyTarget.value)) {
      this.reminderDaysButtonsTarget.classList.add("hidden")
      this.selectFieldTarget.classList.remove("hidden")
      this.selectFieldTarget.removeAttribute("multiple")

      if (this.frequencyTarget.value === "monthly") {
        this.selectLabelTarget.innerText = "Monthly on the first"
      } else {
        this.selectLabelTarget.innerText = "Weekly on this day"
      }
    }
  }

  toggleIsReminderEnabled(e) {
    if (e.target.checked) {
      this.reminderSectionTarget.classList.remove("hidden")
    } else {
      this.reminderSectionTarget.classList.add("hidden")
    }
  }
}