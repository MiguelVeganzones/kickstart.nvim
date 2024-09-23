return({
	"danymat/neogen",
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
	config = function()
		require("neogen").setup({
			vim.api.nvim_set_keymap(
				"n",
				"<leader>nf",
				":lua require('neogen').generate()<CR>",
				{ noremap = true, silent = true }
			),
			languages = {
				["cpp.doxygen"] = require("neogen.configurations.cpp"),
				["python.numpydoc"] = require("neogen.configurations.python"),
			},
		})
	end,
})
