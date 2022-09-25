import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="grid-subscription"
export default class extends Controller {
  static values = { gridId: Number, userId: Number }
  static targets = ["grid"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GridChannel", id: this.gridIdValue },
      { received: (data) => {
        if (this.userIdValue !== data.user_id)
        this.gridTarget.innerHTML = data.grid_html
      } }
    )
    console.log(`Subscribe to the grid with the id ${this.gridIdValue}.`)
  }
}
