vim.g.opencode_opts = {}

vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
	require("opencode").ask("@buffer ", { submit = true })
end, { desc = "[O]pen Code [A]sk…" })

vim.keymap.set({ "v" }, "<leader>oa", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "[O]pen Code [A]sk…" })

vim.keymap.set({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "t" }, "<leader>ot", function()
	require("opencode").toggle()
end, { desc = "[O]pencode [T]oggle" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })

vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
vim.g.opencode_opts = {
	provider = {
		enabled = "tmux",
		tmux = {},
	},
}
