return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets", -- Prebuilt snippets for many languages
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets
	end
}
