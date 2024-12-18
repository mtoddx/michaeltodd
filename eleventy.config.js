module.exports = function(eleventyConfig) {

    eleventyConfig.addCollection("post", function(collectionApi) {
        return collectionApi.getFilteredByGlob("src/posts/*.md");
    });

    eleventyConfig.addPassthroughCopy("src/css");
  
    return {
      dir: {
        input: "src",
        includes: "_includes", // Folder for layouts
        output: "dist"
      }
    };
  };