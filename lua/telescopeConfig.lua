-- Find files using Telescope command-line sugar.
local builtin = require('telescope.builtin')
nmap('<c-p>', builtin.find_files, {})
nmap('<c-g>', builtin.live_grep, {})
nmap('ff', builtin.find_files, {})
nmap('fg', builtin.live_grep, {})
nmap('fb', builtin.buffers, {})
nmap('fh', builtin.help_tags, {})

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
