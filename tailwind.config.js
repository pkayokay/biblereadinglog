const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/components/*.rb",
    "./app/components/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      screens: {
        xs: "460px",
      },
      fontSize: {
        "modal-heading": ["1.75rem", "2.25rem"],
        subheading: ["1.35rem", "2.25rem"],
      },
      boxShadow: {
        custom: "0px 0px 20px 0px rgba(226, 221, 215, 0.5)",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
