return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = lint.linters_by_ft or {}
    lint.linters_by_ft['yaml.github'] = { 'actionlint' }
    lint.linters_by_ft['markdown'] = { 'vale' }
    lint.linters_by_ft['javascript'] = { 'eslint' }
    lint.linters_by_ft['typescript'] = { 'eslint' }
    lint.linters_by_ft['dockerfile'] = { 'hadolint' }
    lint.linters_by_ft['json'] = { 'jsonlint' }
    lint.linters_by_ft['terraform'] = { 'tflint' }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
