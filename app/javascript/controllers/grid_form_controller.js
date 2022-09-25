import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grid-form"
export default class extends Controller {
  static targets = ["checkbox", "select"]
  connect() {
  }

  uncheckIA() {
    this.checkboxTarget.checked = false
  }

  unselectOpponent() {
    this.selectTarget.value = null
  }
  toggleIA(e) {
    if (e.currentTarget === this.selectTarget) {
      this.uncheckIA()
    } else {
      this.unselectOpponent()
    }
  }
}
