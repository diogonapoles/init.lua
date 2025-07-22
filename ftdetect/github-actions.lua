vim.filetype.add {
  pattern = {
    ['.*/%.github/(workflows|actions)[%w/]*%.ya?ml'] = 'yaml.github',
  },
}
