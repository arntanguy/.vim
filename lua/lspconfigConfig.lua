local lspconfig = require('lspconfig')
local navbuddy = require('nvim-navbuddy')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- XXX consider using <C-q> instead for consistency with Telescope
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  function bufopts(desc)
    return { noremap=true, silent=true, buffer=bufnr, desc = desc }
  end
  -- local bufopts = 
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("[LSP] Go to declaration"))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("[LSP] Go to definition"))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts("[LSP] Manual Hover"))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts("[LSP] Go to implementation"))
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts("[LSP] Show signature"))
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts("[LSP] Add workspace folder"))
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts("[LSP] Remove workspace folder"))
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts("[LSP] List workspace folders"))
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts("[LSP] Type definition"))
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts('[LSP] Rename'))
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts('[LSP] Code action'))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts('[LSP] References'))
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts('[LSP] Format'))
end

-- python
lspconfig.pyright.setup{}

-- C++ Compilation
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- ccls_capabilities.offsetEncoding = "utf-8"
lspconfig.ccls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    highlight = {
      lsRanges = true
    }
  }
}

-- The following example advertise capabilities to `clangd`.
local clangd_capabilities = capabilities
-- Why is this an issue?
clangd_capabilities.offsetEncoding = "utf-16"
lspconfig.clangd.setup {
  cmd = { "/usr/bin/clangd-12" },
  capabilities = clangd_capabilities,
  on_attach = function(client, bufnr)
    navbuddy.attach(client, bufnr)
  end
}


--
-- LUA
--
local sumneko_root_path = os.getenv("HOME") ..
                              "/src/ext/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
lspconfig.lua_ls.setup({
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            completion = {enable = true, callSnippet = "Both"},
            diagnostics = {
                enable = true,
                globals = {'vim', 'describe'},
                disable = {"lowercase-global"}
            },
            workspace = {
                library = {
                    -- Make the server aware of Neovim runtime files
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    [vim.fn.expand('/usr/share/awesome/lib')] = true
                },
                -- adjust these two values if your performance is not optimal
                maxPreload = 2000,
                preloadFileSize = 1000
            }
        }
    },
    on_attach = on_attach
})

-- Suppresses error:
-- warning: multiple different client offset_encodings detected for buffer, this is not supported yet #428
-- See https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

lspconfig.tsserver.setup{}
