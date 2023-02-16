-- map to <Leader>cf in C++ code
nmap('<leader>cf', ':ClangFormat<CR>')
vmap('<leader>cf', ':ClangFormat<CR>')

-- vim.api.nvim_create_autocmd(
-- "FileType", {pattern = {"c", "cpp"}, command = [[ :ClangFormatAutoEnable<CR> ]] })
