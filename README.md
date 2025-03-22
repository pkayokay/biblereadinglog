# README

## About

This project is a simple Bible reading tracker, you can try it at https://my.biblereadinglog.com

The core features are:

1. Multiple Reading Logs: create separate reading logs for your yearly plan, Bible study, or small group reading, all in one place.
2. Timeless Tracking: no need for start or end dates.
3. Email Reminders: stay engaged and consistent with friendly email nudges.
4. Reading Groups: join others or invite them to read the Bible together.

## Tech Stack

This is built on Ruby on Rails (Hotwire), TailwindCSS, ViewComponent and PostgresQL.

## Working Locally

A prerequisite for this project is that you have Ruby and Ruby on Rails installed.

1. `bundle install`
2. `yarn install`
3. `bin/dev`
4. Visit https://localhost:3000.

## Linters

1. Prettier for `.js` files, run `yarn format`
2. Standardrb for `.rb` files, run `bundle exec standard --fix`
3. Erblint for `.erb` files, run `bundle exec erblint --lint-all -a`

To run all of them, run `bin/lint` in the terminal.
