vim.opt.termguicolors  = true
vim.opt.mouse          = "a"
vim.opt.undofile       = true
vim.opt.shell          = "/bin/zsh"
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.clipboard      = "unnamedplus"

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = 4
vim.opt.autoindent  = true
vim.opt.smartindent = true

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.updatetime = 300
vim.opt.ttimeoutlen = 100

vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.g.mapleader        = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup('plugins')

-- "Navigate by display lines instead of regular lines
vim.api.nvim_set_keymap("", "j", "gj", {noremap = true})
vim.api.nvim_set_keymap("", "k", "gk", {noremap = true})

-- "Switch splits quickly
vim.api.nvim_set_keymap("", "<c-j>", "<c-w>j", {noremap = true})
vim.api.nvim_set_keymap("", "<c-k>", "<c-w>k", {noremap = true})
vim.api.nvim_set_keymap("", "<c-h>", "<c-w>h", {noremap = true})
vim.api.nvim_set_keymap("", "<c-l>", "<c-w>l", {noremap = true})

-- " Open Terminal
vim.api.nvim_set_keymap("n", "tt", ":split<Bar>terminal<CR>", {noremap = true})


-- "Save me from misspressing shift
vim.cmd("command! W :w")
vim.cmd("command! Q :q")


vim.cmd("set noshowmode")
-- vim.cmd("colorscheme dracula")
vim.cmd("let g:sonokai_style = 'shusia'")
vim.cmd("let g:sonokai_better_performance = 1")
vim.cmd("let g:sonokai_enable_italic = 1")
vim.cmd("let g:sonokai_diagnostic_virtual_text = 'colored'")
vim.cmd("colorscheme sonokai")
vim.cmd("set dictionary=spell,~/.config/nvim/dict/en.dict,~/.config/nvim/dict/el.dict")
