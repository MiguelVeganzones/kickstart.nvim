---
----------------------------------------------------------------------------------------------
--------------------- General ----------------------------------------------------------------
----------------------------------------------------------------------------------------------
---- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- python path
vim.g.python3_host_prog = "/usr/bin/python3"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Ignore these files in auto complete
vim.opt.wildignore = { "*.o", "*.a", "*.obj" }

-- Save undo history
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.o.compatible = false
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.swapfile = false

---
----------------------------------------------------------------------------------------------
--------------------- Search -----------------------------------------------------------------
----------------------------------------------------------------------------------------------
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
---
----------------------------------------------------------------------------------------------
--------------------- Clip board -------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- -- Sync clipboard between OS and Neovim.
-- --  Remove this option if you want your OS clipboard to remain independentv
-- --  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>y",
	'"+y',
	{ noremap = true, silent = true, desc = "Yank to system clipboard" }
)
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>Y",
	'"+Y',
	{ noremap = true, silent = true, desc = "Yank to system clipboard" }
)
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>p",
	'"+p',
	{ noremap = true, silent = true, desc = "Paste from system clipboard" }
)
vim.keymap.set(
	{ "n", "v", "x" },
	"<leader>P",
	'"+P',
	{ noremap = true, silent = true, desc = "Paste from system clipboard" }
)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

---
----------------------------------------------------------------------------------------------
--------------------- Appearance -------------------------------------------------------------
----------------------------------------------------------------------------------------------
-- Wrapping
vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.breakat = " ^I!@*-+;:,./?" -- default
vim.opt.breakindent = true
-- Cursor
vim.opt.scrolloff = 15
vim.opt.cursorline = true
-- Text
vim.opt.list = true
vim.opt.listchars = { -- Show unprintable symbols
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "►",
	precedes = "◄",
	conceal = "▒",
}
-- Column
vim.opt.number = true -- Make relative line numbers default
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

---
----------------------------------------------------------------------------------------------
--------------------- Windows ----------------------------------------------------------------
----------------------------------------------------------------------------------------------
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<M-,>", "<C-w>5<", { desc = "Resize window thinner" })
vim.keymap.set("n", "<M-.>", "<C-w>5>", { desc = "Resize window wider" })

---
----------------------------------------------------------------------------------------------
--------------------- Diagnostics -----------------------------------------------------------
----------------------------------------------------------------------------------------------

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

---
----------------------------------------------------------------------------------------------
--------------------- Unclassified -----------------------------------------------------------
----------------------------------------------------------------------------------------------

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrows in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

---
----------------------------------------------------------------------------------------------
--------------------- Plugin manager ---------------------------------------------------------
----------------------------------------------------------------------------------------------

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	require("kickstart.autopairs"),
	require("kickstart.lint"),
	require("plugins.autocomplete"),
	require("plugins.autoformat"),
	require("plugins.autosave"),
	require("plugins.autotabwidth"),
	require("plugins.colorscheme"),
	require("plugins.dap"),
	require("plugins.diffview"),
	require("plugins.gitsigns"),
	require("plugins.lsp"),
	require("plugins.md_headlines"),
	require("plugins.mini"),
	require("plugins.multi_cursor"),
	require("plugins.neogen"),
	require("plugins.oil"),
	require("plugins.telescope"),
	require("plugins.todo_comments"),
	require("plugins.treesitter"),
	require("plugins.vim_tmux_navigator"),
	require("plugins.vimtex"),
	require("plugins.which_key"),
})
