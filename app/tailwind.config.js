const colors = require('tailwindcss/colors');
const defaultTheme = require("tailwindcss/defaultTheme");
module.exports = {
  purge: ["./_layouts/*.html"],
  darkMode: "media",
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
      },
      spacing: {
        128: "32rem",
      },
      colors: {
        gray: colors.blueGray,
      },
      typography: (theme) => ({
        light: {
          css: [
            {
              color: theme('colors.gray.200'),
              '[class~="lead"]': {
                color: theme('colors.gray.300'),
              },
              a: {
                color: theme('colors.gray.50'),
              },
              strong: {
                color: theme('colors.gray.50'),
              },
              'ol > li::before': {
                color: theme('colors.gray.400'),
              },
              'ul > li::before': {
                backgroundColor: theme('colors.gray.600'),
              },
              hr: {
                borderColor: theme('colors.gray.200'),
              },
              blockquote: {
                color: theme('colors.gray.200'),
                borderLeftColor: theme('colors.gray.600'),
              },
              h1: {
                color: theme('colors.gray.50'),
              },
              h2: {
                color: theme('colors.gray.50'),
              },
              h3: {
                color: theme('colors.gray.50'),
              },
              h4: {
                color: theme('colors.gray.50'),
              },
              'figure figcaption': {
                color: theme('colors.gray.400'),
              },
              code: {
                color: theme('colors.gray.50'),
              },
              'a code': {
                color: theme('colors.gray.50'),
              },
              pre: {
                color: theme('colors.gray.50'),
                backgroundColor: theme('colors.gray.800'),
              },
              thead: {
                color: theme('colors.gray.50'),
                borderBottomColor: theme('colors.gray.400'),
              },
              'tbody tr': {
                borderBottomColor: theme('colors.gray.600'),
              },
            },
          ],
        },
      }),
    },
  },
  variants: {
    extend: {
      typography: ['dark'],
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
