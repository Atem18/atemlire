const Image = require("@11ty/eleventy-img");
const {
  DateTime
} = require('luxon');
const htmlmin = require("html-minifier");
const now = String(Date.now());
const site = require("./_data/site.json")
const util = require('util');


module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy({
    "./assets/favicons": "./"
  });
  eleventyConfig.addPassthroughCopy({
    "./assets/img": "img"
  });
  eleventyConfig.addPassthroughCopy({
    "./assets/webfonts": "webfonts"
  });
  eleventyConfig.addPassthroughCopy({
    './node_modules/alpinejs/dist/cdn.min.js': './alpine.js',
  })

  eleventyConfig.addWatchTarget("./tailwind.config.js");
  eleventyConfig.addWatchTarget("./assets/css/style.css");

  eleventyConfig.addCollection('posts', function (collection) {
    if (process.env.ELEVENTY_ENV !== 'production')
      return collection.getFilteredByGlob('./_posts/*.md');
    return collection.getFilteredByGlob('./_posts/*.md').filter((post) => !post.data.draft);
  });

  eleventyConfig.addCollection('pages', function (collection) {
    if (process.env.ELEVENTY_ENV !== 'production')
      return collection.getFilteredByGlob('./_pages/*.md')
    return collection.getFilteredByGlob('./_pages/*.md').filter((post) => !post.data.draft);
  });

  eleventyConfig.addShortcode("version", function () {
    return now;
  });

  eleventyConfig.addTransform("htmlmin", function (content, outputPath) {
    if (
      process.env.ELEVENTY_PRODUCTION &&
      outputPath &&
      outputPath.endsWith(".html")
    ) {
      return htmlmin.minify(content, {
        collapseWhitespace: true,
        removeComments: true,
        useShortDoctype: true
      });
    }
    return content;
  });

  eleventyConfig.addFilter('console', function (value) {
    const str = util.inspect(value);
    return `<div style="white-space: pre-wrap;">${unescape(str)}</div>;`
  });

  eleventyConfig.addFilter('date', (dateObj, format) => {
    return DateTime.fromJSDate(dateObj).toFormat(format);
  });

  eleventyConfig.addFilter("getPostsByAuthor", (posts, author) => {
    return posts.filter(a => a.data.author === author);
  });

  eleventyConfig.addFilter("getPostsByTag", (posts, tag) => {
    return posts.filter(a => a.data.tags.find(b => b === tag));
  });

  eleventyConfig.addFilter('readingTime', function (text) {
    // get entire post content element
    let wordCount = `${text}`.match(/\b[-?(\w+)?]+\b/gi).length;
    //calculate time in munites based on average reading time
    let timeInMinutes = (wordCount / 225)
    //validation as we don't want it to show 0 if time is under 30 seconds
    let output;
    if (timeInMinutes <= 0.5) {
      output = 0;
    } else {
      //round to nearest minute
      output = Math.round(timeInMinutes);
    }
    return `${output}`;
  });

  async function imageShortcode(src, title, alt, cls, sizes = '100vw', widths = [null, 100, 300, 500, 750, 1000, 1500, 2500]) {
    let metadata = await Image(src, {
      widths,
      formats: ["webp", "jpeg"],
      outputDir: "./_site/img/"
    });

    let imageAttributes = {
      title,
      alt,
      class: cls,
      sizes,
      loading: "lazy",
      decoding: "async",
    };

    // You bet we throw an error on missing alt in `imageAttributes` (alt="" works okay)
    return Image.generateHTML(metadata, imageAttributes);
  }

  async function imageHomeShortcode(src, title, alt, cls, sizes = '100vw', widths = [null, 100, 300, 500, 750, 1000, 1500, 2500]) {
    let metadata = await Image(src, {
      widths,
      formats: ["webp", "jpeg"],
      outputDir: "./_site/img/"
    });

    let imageAttributes = {
      title,
      alt,
      class: cls,
      sizes,
      decoding: "async",
    };

    // You bet we throw an error on missing alt in `imageAttributes` (alt="" works okay)
    return Image.generateHTML(metadata, imageAttributes);
  }

  eleventyConfig.addNunjucksAsyncShortcode("image", imageShortcode);

  eleventyConfig.addNunjucksAsyncShortcode("imageHome", imageHomeShortcode);

  return {
    markdownTemplateEngine: "njk",
    dir: {
      // ⚠️ These values are both relative to your input directory.
      includes: "_includes",
      layouts: "_layouts"
    }
  }

};