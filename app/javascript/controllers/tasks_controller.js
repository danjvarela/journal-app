import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['checkbox']
  static values = { updatePath: String, categoryId: Number }

  connect () {}

  checkboxChanged () {
    const body = {
      task: { done: this.checkboxTarget.checked },
      category_id: this.categoryIdValue
    }

    fetch(this.updatePathValue, {
      method: 'PUT',
      body: JSON.stringify(body),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
        accept: 'application/json'
      }
    })
  }
}
