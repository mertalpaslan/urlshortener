const urlInput = document.getElementById('urlInput')
const shortenButton = document.getElementById('shortenButton')
const confirmationBox = document.getElementById('confirmationBox')
const confirmationText = document.getElementById('confirmationText')
const confirmButton = document.getElementById('confirmButton')
const cancelButton = document.getElementById('cancelButton')
const errorBox = document.getElementById('errorBox')
const resultBox = document.getElementById('resultBox')
const shortUrl = document.getElementById('shortUrl')
const resultLabel = document.getElementById('resultLabel')

shortenButton.addEventListener('click', confirmShorten)
confirmButton.addEventListener('click', shortenUrl)
cancelButton.addEventListener('click', hideConfirmationBox)
urlInput.onkeydown = function (e) {
  window.e = e
  if (e.key == 'Enter') confirmShorten()
}

function confirmShorten() {
  hideError()
  hideResult()

  const fullUrl = urlInput.value
  if (fullUrl) {
    confirmationText.innerHTML = `Is the URL you want to shorten: <a href="//${fullUrl}">${fullUrl}</a> ?`
    confirmationBox.classList.remove('is-hidden')
  } else {
    showError('Please enter a valid URL.')
  }
}

function hideConfirmationBox() {
  confirmationBox.classList.add('is-hidden')
}

function shortenUrl() {
  const fullUrl = urlInput.value
  hideConfirmationBox()

  fetch('/shorten', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: `url=${encodeURIComponent(fullUrl)}`,
  })
    .then((response) => response.json())
    .then((data) => {
      window.data = data
      if (data.error) {
        showError(data.error)
      } else {
        showShortenedUrl(data)
      }
    })
    .catch((error) => {
      showError('An error occurred. Please try again later.')
      console.error(error)
    })
}

function showShortenedUrl(data) {
  shortUrl.value = data.short
  resultLabel.innerHTML = `Shortened URL for <a href="${data.long}">${data.long};`
  resultBox.classList.remove('is-hidden')
}

function showError(message) {
  errorBox.textContent = message
  errorBox.classList.remove('is-hidden')
}

function hideError() {
  errorBox.classList.add('is-hidden')
}

function hideResult() {
  resultBox.classList.add('is-hidden')
}

const copyButton = document.getElementById('copyButton')
copyButton.addEventListener('click', copyToClipboard)

function copyToClipboard() {
  const shortUrl = document.getElementById('shortUrl')
  shortUrl.select()
  shortUrl.setSelectionRange(0, 99999)
  document.execCommand('copy')
  copyButton.textContent = 'Copied!'
  setTimeout(() => {
    copyButton.textContent = 'Copy'
  }, 2000)
}
