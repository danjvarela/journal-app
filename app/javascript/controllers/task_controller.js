import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="task"
export default class extends Controller {
  updateComplete() {
    this.element.closest("form").requestSubmit();
  }
}
