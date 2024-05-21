import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Modal } from "tailwindcss-stimulus-components"
application.register('modal', Modal)

import Clipboard from '@stimulus-components/clipboard'
application.register('clipboard', Clipboard)