local options = {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "dist/",
      "build/",
      "target/",
      "%.lock",
    },
  },
}

return options
