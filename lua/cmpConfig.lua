local cmp = require'cmp'

cmp.setup {
  sources = {
    { name = 'nvim_lsp' }, -- Use the LSP server as completion source
    { name = 'nvim_lsp_signature_help' }
  }
}
