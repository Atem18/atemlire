module.exports = {
  purge: [
    "./_includes/*.html",
    "./_layouts/*.html",
    "./_posts/*.md",
  ],
  darkMode: false,
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require("@tailwindcss/typography")],
};
