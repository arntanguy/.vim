local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'hrsh7th/cmp-nvim-lsp'
      },
      {
        'hrsh7th/cmp-buffer'
      },
      {
        'hrsh7th/cmp-path'
      },
      {
        'hrsh7th/cmp-cmdline'
      }
    }
  }

  -- Clang-format code
  use 'rhysd/vim-clang-format'
  -- Aligns stuff vertically 
  use 'junegunn/vim-easy-align'
  -- Snippets
  use 'SirVer/ultisnips'
  -- Snippets are separated from the engine. Add this if you want them:
  use 'honza/vim-snippets'
  -- Enhanced syntax highlighting for C++
  use 'octol/vim-cpp-enhanced-highlight'
  -- Code
  use 'neomake/neomake'
  use 'bkad/CamelCaseMotion'
  use 'tpope/vim-surround'
  use 'mrtazz/DoxygenToolkit.vim'
  -- comment using gc<command> or gcc (one line or selection)
  use 'tpope/vim-commentary'
  -- theme
  -- Molokai theme
  use 'chriskempson/base16-vim'
  use 'tomasr/molokai'
  use {'arntanguy/harlequin', branch = 'ycm'}
  use 'altercation/vim-colors-solarized'
  use 'croaker/mustang-vim'
  use 'bling/vim-airline'
  -- I3
  use 'PotatoesMaster/i3-vim-syntax'
  -- LaTeX support
  use 'lervag/vimtex'
  -- Seamless navigation between tmux
  -- and vim with C-[h|j|k|l]
  use 'christoomey/vim-tmux-navigator'
end)

