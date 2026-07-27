return {
	"mistweaverco/kulala.nvim",
	-- load before session save/restore so kulala's hooks register correctly
	event = { "SessionLoadPost", "VimLeavePre" },
	ft = { "http", "rest" },
	opts = {
		-- enables the ,R-prefixed global keymaps below (send request, send all, etc.)
		global_keymaps = true,
		global_keymaps_prefix = ",R",

		-- kulala's own UI-buffer keymaps (H/B/A/V/S/O/R views, [ ] history, etc.)
		kulala_keymaps = true,

		-- optional: use black/gofumpt-style formatting on .http files if you add one later
		-- default_view = "body",
	},
	keys = {
		{ ",Rs", desc = "Kulala: Send request" },
		{ ",Ra", desc = "Kulala: Send all requests" },
		{ ",Rb", desc = "Kulala: Open scratchpad" },
		{ ",Ro", desc = "Kulala: Open response UI" },
		{ ",Re", desc = "Kulala: Select environment" },
	},
}
