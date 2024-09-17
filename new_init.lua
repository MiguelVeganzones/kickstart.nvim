---- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- python path
vim.g.python3_host_prog = '/usr/bin/python3'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Ignore these files in auto complete
vim.opt.wildignore = { '*.o', '*.a', '*.obj' }

-- Show unprintable symbols
vim.opt.list = true
vim.opt.listchars = 
{ 
	tab = '» ',
	trail = '·',
	nbsp = '␣',
	extends = '►',
	precedes = '◄',
	conceal = '▒'
}

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

---
----------------------------------------------------------------------------------------------
--------------------- Colum ------------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- Make relaitve line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes' -- TODO Check yes:1 and coloring line number for diagnostics. Other

---
----------------------------------------------------------------------------------------------
--------------------- Clip board -------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- -- Sync clipboard between OS and Neovim.
-- --  Remove this option if you want your OS clipboard to remain independentv
-- --  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>yy', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>Y', '"+Y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>P', '"+P', { noremap = true, silent = true, desc = 'Paste from system clipboard' })

---
----------------------------------------------------------------------------------------------
--------------------- Text width -------------------------------------------------------------
----------------------------------------------------------------------------------------------
vim.opt.wrap = true
vim.opt.sidescroll = 5
vim.opt.linebreak = true
vim.opt.breakat = ' ^I!@*-+;:,./?' -- default
-- Enable break indent
vim.opt.breakindent = true
