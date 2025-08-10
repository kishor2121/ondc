import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["qty"]

  increment(e) {
    const input = e.currentTarget.previousElementSibling
    input.value = parseInt(input.value || 0) + 1
  }

  decrement(e) {
    const input = e.currentTarget.nextElementSibling
    input.value = Math.max(1, parseInt(input.value || 1) - 1)
  }
}
