const plugins = [require('postcss-import'), require('tailwindcss'), require('autoprefixer')()];

if (process.env.JEKYLL_ENV === 'production') {
  plugins.push(
    require('postcss-csso')({
      restructure: false
    }),
  );
}

module.exports = {
  plugins,
};
