return {
  'sainnhe/gruvbox-material',
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_foreground = 'medium'
    vim.g.gruvbox_material_ui_contrast = 'medium'

    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
