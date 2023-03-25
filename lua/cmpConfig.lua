local cmp = require'cmp'

cmp.setup {
  sources = {
    { name = 'nvim_lsp' } -- Use the LSP server as completion source
  },
}
