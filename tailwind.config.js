const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/components/*.rb',
    './app/components/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      screens: {
        'xs': '440px',
      },
      fontSize: {
        'heading': ['1.9rem','2.25rem'],
        'subheading': ['1.35rem','2.25rem']
      }
    },
  },
  plugins: [require('@tailwindcss/forms')],
}
