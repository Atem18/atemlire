const defaultTheme = require("tailwindcss/defaultTheme");
module.exports = {
  purge: ["./_includes/*.html", "./_layouts/*.html", "./_pages/*.html", "./_posts/*.md"],
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
      },
      spacing: {
        '128': '32rem',
      },
    },
  },
  variants: {},
  plugins: [require("@tailwindcss/typography")],
};
