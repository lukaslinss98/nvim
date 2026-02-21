require("snacks").setup({
	image = { enabled = true },
	bigfile = { enabled = true },
	statuscolumn = { enabled = true },
	picker = { enabled = true },
	indent = {
		enable = true,
		animate = {
			enabled = false,
		},
	},
	input = {
		icon = " ",
		icon_hl = "SnacksInputIcon",
		icon_pos = "left",
		prompt_pos = "title",
		win = { style = "input" },
		expand = true,
	},
	dashboard = {
		preset = {
			pick = nil,
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
		},
		sections = {
			{ section = "header" },
			{
				section = "keys",
				indent = 1,
				padding = 1,
			},
			-- { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 3, padding = 2 },
			-- { section = "startup" },
		},
	},
	backends = {
		ghostty = true,
		tmux = true,
	},
	features = {
		markdown = true,
		latex = false,
		mermaid = false,
	},
})
