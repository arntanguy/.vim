-- helper functions to simplify mapping
function map(mode, shortcut, command, options)
  -- vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
  vim.keymap.set(mode, shortcut, command, options)
end

function nmap(shortcut, command, options)
  map('n', shortcut, command, options)
end

function vmap(shortcut, command, options)
  map('v', shortcut, command, options)
end

function imap(shortcut, command, options)
  map('i', shortcut, command, options)
end
