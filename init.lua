-- ================================================================================
-- =============================== Global Config===================================
-- ================================================================================
--

require('plugins')
require('utils')
require('telescopeConfig')
-- Language Server Protocol (uses external language servers to handle compilation and completion)
-- Uses vim-cmp for code completion
require('cmpConfig')
-- For c++ this uses clangd LSP
require('lsp-kindConfig')
require('lspconfigConfig')
require('clang-format')
require('lualineConfig')
require('autotagConfig')
require('autopairConfig')

vim.g.mapleader = ','
vim.g.maplocalleader = ','
-- By default timeoutlen is 1000 ms
vim.g.timeoutlen = 500

vim.opt.foldmethod = 'syntax'

-- Quickfix list
nmap(']q', ':cn<CR>')
nmap('[q', ':cp<CR>')

-- Persistent undo
vim.opt.undolevels=5000
vim.opt.undodir=os.getenv("HOME") .. '/.VIM_UNDO_FILES'
vim.opt.undofile=true

vim.opt.mouse='a' -- enable mouse support

-- Appearance
-- Lua:
-- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme tokyonight-moon]]
-- vim.cmd[[colorscheme tokyonight-night]]
--
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme nightfox]]
vim.cmd[[colorscheme duskfox]]
-- vim.cmd('colorscheme harlequin')
vim.opt.cursorline=true -- " highlight current line
vim.cmd('hi CursorLine term=bold cterm=bold guibg=Grey40')
vim.opt.number=true -- show line number
vim.opt.relativenumber=true -- show numbers relative to current line
-- Folding
vim.opt.foldmethod='syntax'
-- All folds open by default
vim.opt.foldlevel=100

-- Tabulations
vim.opt.shiftwidth=2
vim.opt.tabstop=2
vim.opt.expandtab=true -- Spaces instead of tabs
vim.opt.smartindent=true

-- Completion in command line
vim.opt.wildignore={'*.o','*.r','*.so','*.sl','*.tar','*.tgz'}

-- {{{ CamelCase
-- Use default mappings ,w ...
vim.cmd("call camelcasemotion#CreateMotionMappings('<leader>')")
-- }}}

-- " vim-commentary {{{
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {"c", "cpp"}, command = [[ set commentstring=//\ %s ]] })
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {"cmake"}, command = [[ set commentstring=#\ %s ]] })
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {"matlab"}, command = [[ setlocal commentstring=%\ %s ]] })
-- " }}}
--

-- GLSL
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {'*.frag','*.vert','*.geom','*gp','*.fp','*.vp','*.glsl'}, command = [[ setf glsl ]] })
-- Opencl
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {'*.cl'}, command = [[ set filetype=opencl ]] })
-- Json
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {'*.conf', '*.conf.json'}, command = [[ set filetype=json ]] })
-- XML
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {'*.rsdf'}, command = [[ set filetype=xml ]] })
-- Markdown
vim.api.nvim_create_autocmd( 
"FileType", {pattern = {'*.md'}, command = [[ set filetype=markdown ]] })

-- Vim-airline {{{
local gset = vim.api.nvim_set_var
gset('airline_powerline_fonts', 1)
gset('airline#extensions#whitespace#enabled', 0)
-- }}}

-- Markdown {
-- Disable folding
vim.g.vim_markdown_folding_disabled=1
-- Set initial foldlevel. (default is 0: all closed)
vim.g.vim_markdown_initial_foldlevel=1
-- }

-- UtilsSnips {{{
-- Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
vim.g.UltiSnipsExpandTrigger="<c-j>"
vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"
-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit="vertical"
--  }}}

-- remaps annoying ex mode to repeat macro
-- nmap('Q', '@@')


vim.cmd([[
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      %s/\s\+$//e
      normal 'yz<CR>
      normal `z
    endif
endfunction
autocmd FileType c,cpp autocmd BufWritePre <buffer> :%s/\s\+$//e
]])
