// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { application } from "./application"

// Register each controller with Stimulus
import controllers from "./**/*_controller.js"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})

// Import and register all TailwindCSS Components or just the ones you need
// import { Alert, Autosave, ColorPreview, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
import { Autosave } from "tailwindcss-stimulus-components"
// application.register('alert', Alert)
application.register('autosave', Autosave)
// application.register('color-preview', ColorPreview)
// application.register('dropdown', Dropdown)
// application.register('modal', Modal)
// application.register('popover', Popover)
// application.register('slideover', Slideover)
// application.register('tabs', Tabs)
// application.register('toggle', Toggle)