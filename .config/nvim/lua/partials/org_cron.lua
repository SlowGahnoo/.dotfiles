-- ~/.config/nvim/lua/partials/org_cron.lua

-- If you are using lazy.vim do this:
local treesitter = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter'
local orgmode = vim.fn.stdpath('data') .. '/lazy/orgmode'
vim.opt.runtimepath:append(orgmode)
vim.opt.runtimepath:append(treesitter)

require('orgmode').cron({
	org_agenda_files = '~/orgfiles/**/*',
	org_default_notes_file ='~/orgfiles/refile.org',
})
