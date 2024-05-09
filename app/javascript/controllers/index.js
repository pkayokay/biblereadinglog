// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BookSelectionController from "./book_selection_controller"
application.register("book-selection", BookSelectionController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ReadingLogIndexController from "./reading_log_index_controller"
application.register("reading-log-index", ReadingLogIndexController)

import ReminderFormController from "./reminder_form_controller"
application.register("reminder-form", ReminderFormController)

import TimeZoneController from "./time_zone_controller"
application.register("time-zone", TimeZoneController)
