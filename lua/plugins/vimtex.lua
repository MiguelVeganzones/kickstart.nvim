-- vimtex.lua
return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_complete_close_braces = 1
		vim.g.vimtex_quickfix_open_on_warning = 0
		-- vim.g.vimtex_view_method = 'skim'
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_view_skim_sync = 1
		vim.g.wimtex_view_skim_activate = 1
		vim.g.vimtex_mappings_enabled = 1
		vim.g.vimtex_indent_enabled = 1
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_log_ignore = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}
		vim.g.vimtex_context_pdf_viewer = "zathura"
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
	end,
}
