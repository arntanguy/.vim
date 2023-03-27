-- Find files using Telescope command-line sugar.
local builtin = require('telescope.builtin')
nmap('<c-p>', builtin.find_files, { desc = 'Telescope find_files' })
nmap('ff', builtin.find_files, { desc = 'Telescope find_files' })
nmap('fg', builtin.live_grep, { desc = 'Telescope live_grep' })
nmap('fb', builtin.buffers, { desc = 'Telescope buffers' })
nmap('fh', builtin.help_tags, { desc = 'Telescope help_tags' })
nmap('fr', builtin.resume, { desc = 'Telescope resume' })

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
