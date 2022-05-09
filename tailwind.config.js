const colors = require('tailwindcss/colors');
const defaultTheme = require("tailwindcss/defaultTheme");
module.exports = {
  content: ['_site/**/*.html'],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        gray: colors.slate,
      },
    }
  },
  plugins: [require("@tailwindcss/typography")],
};