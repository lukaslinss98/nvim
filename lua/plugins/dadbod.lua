local sql_ft = { "sql", "mysql", "plsql" }

return {
	{ "tpope/vim-dadbod", cmd = "DB" },

	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod" },
		ft = sql_ft,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "[D]ata[b]ase UI toggle" },
			{ "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "[D]atabase [F]ind buffer" },
			{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "[D]atabase [A]dd connection" },
		},
		init = function()
			local data_path = vim.fn.stdpath("data")
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_use_nvim_notify = 1 -- routes through vim.notify -> snacks notifier
			vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
			vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_execute_on_save = 0 -- run explicitly with <leader>S, not on every :w
			-- disable Neovim's built-in sql omni completion so it doesn't compete with blink
			vim.g.loaded_sql_completion = true
			vim.g.omni_sql_default_compl_type = "syntax"
		end,
	},
}
