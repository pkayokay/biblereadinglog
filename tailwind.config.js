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
    },
  },
  plugins: [require('@tailwindcss/forms')],
}
