return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({ 'javascript', 'tsx' })
    vim.treesitter.language.register('javascript', 'javascriptreact')
    vim.treesitter.language.register('tsx', 'typescriptreact')

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('JsxIndent', { clear = true }),
      pattern = { 'javascriptreact', 'typescriptreact' },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
