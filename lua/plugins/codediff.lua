return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{ "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Git diff" },
	},
	opts = {
		highlights = {
			line_insert = "DiffAdd",
			line_delete = "DiffDelete",
			char_insert = nil,
			char_delete = nil,
			char_brightness = nil,
		},
		diff = {
			layout = "side-by-side",
			filler_text = "╱",
			disable_inlay_hints = true,
			max_computation_time_ms = 5000,
			ignore_trim_whitespace = false,
			original_position = "left",
			jump_to_first_change = true,
			gutter_signs = true,
			compute_moves = false,
			compact_context_lines = 3,
		},
	},
}
