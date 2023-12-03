import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["feedback", "passIcon", "failIcon", "password"]

  static values = {
    requiredLength: {
      type: Number
    },
    requireLowercaseLetter: {
      type: Boolean,
      default: true
    },
    requireUppercaseLetter: {
      type: Boolean,
      default: true
    },
    requireNumber: {
      type: Boolean,
      default: true
    },
    requireSymbols: {
      type: Boolean,
      default: true
    },
    allowIdenticalCharacters: {
      type: Boolean,
      default: false
    },
    allowSequentialCharacters: {
      type: Boolean,
      default: false
    }
  }

  connect() {
  }

  validate() {
    this._clearFeedback()
    this._validateLowercase()
    this._validateUppercase()
    this._validateLength()
    this._validateNumber()
    this._validateSymbols()
    this._validateIdenticalCharacters()
    this._validateSequentialCharacters()
  }

  _validateLowercase() {
    if (!this.requireLowercaseLetterValue) return;

    let lowerCaseLetters = /[a-z]/g;
    let text = "must include at least 1 lowercase letter"
    let valid = this.rawPassword.match(lowerCaseLetters)
    this._addLineItemToFeedback(valid, text)
  }

  _validateUppercase() {
    if (!this.requireUppercaseLetterValue) return;

    let pattern = /[A-Z]/g;
    let text = "must include at least 1 uppercase letter"
    let valid = this.rawPassword.match(pattern)
    this._addLineItemToFeedback(valid, text)
  }

  _validateLength() {
    if (!this.requiredLengthValue || this.requiredLengthValue === undefined) return;

    let valid = this.rawPassword.length >= this.requiredLengthValue
    let text = `must be at least ${this.requiredLengthValue} characters long`
    this._addLineItemToFeedback(valid, text)
  }

  _validateNumber() {
    if (!this.requireNumberValue) return;

    const pattern = /[0-9]/g;
    let text = "must include at least 1 number"
    let valid = this.rawPassword.match(pattern)
    this._addLineItemToFeedback(valid, text)
  }

  _validateSymbols() {
    if (!this.requireSymbolsValue) return;

    const pattern = /^[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*$/;
    let text = "must include at least 1 symbol"
    let valid = this.rawPassword.match(pattern)
    this._addLineItemToFeedback(valid, text)
  }

  _validateIdenticalCharacters() {
    if (this.allowIdenticalCharactersValue) return;
    const pattern = /([\s\S])\1\1/g;

    let text = "cannot have 3 or more consecutive identical characters"
    let valid = !this.rawPassword.match(pattern)
    this._addLineItemToFeedback(valid, text)
  }

  _validateSequentialCharacters() {
    if (this.allowSequentialCharactersValue) return;

    const pattern = new RegExp(['(abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm',
      '|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz|',
      '012|123|234|345|456|567|678|789)+'].join(''), 'gi');

    let text = "cannot have 3 or more consecutive sequential characters"
    let valid = !this.rawPassword.match(pattern)
    this._addLineItemToFeedback(valid, text)
  }

  _addLineItemToFeedback(valid, text) {
    this._showFeedback()
    let html = this._renderFeedbackItem(valid, text)
    this.feedbackTarget.insertAdjacentHTML("beforeend", html);
  }

  _renderFeedbackItem(valid, text) {
    let icon = valid ? this.passIconTarget : this.failIconTarget;
    let classes = valid ? "text-green-600" : "text-red-600";

    return `<p class="flex space-x-2 items-center ${classes}">${icon.innerHTML}<span>${text}</span></p>`
  }

  _clearFeedback() {
    this.feedbackTarget.innerHTML = ""
  }

  _showFeedback() {
    this.feedbackTarget.classList.remove("hidden")
  }

  _hideFeedback() {
    this.feedbackTarget.classList.add("hidden")
  }

  get rawPassword() {
    return this.passwordTarget.value;
  }
}