import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["open", "closed", "item", "profile", "avatar"]
  connect() {
    console.log("connected")
  }

  toggle(event) {
    event.preventDefault();
    if (this.openTarget.classList.contains('hidden')) {
        this.openTarget.classList.remove("hidden")
        this.openTarget.classList.add("block")
        this.closedTarget.classList.remove("block")
        this.closedTarget.classList.add("hidden")
        this.itemTarget.classList.add("hidden")
        this.profileTarget.classList.add("hidden")
    } else {
        this.openTarget.classList.add("hidden")
        this.openTarget.classList.remove("block")
        this.closedTarget.classList.add("block")
        this.closedTarget.classList.remove("hidden")
        this.itemTarget.classList.remove("hidden")
        this.profileTarget.classList.remove("hidden")
    }
  }
  dashtoggle(event) {
    event.preventDefault();
    if (this.avatarTarget.classList.contains('hidden')) {
        this.avatarTarget.classList.remove("hidden")
        this.avatarTarget.classList.add("block")
   
    } else {
        this.avatarTarget.classList.add("hidden")
        this.avatarTarget.classList.remove("block")

    }
  }
}
