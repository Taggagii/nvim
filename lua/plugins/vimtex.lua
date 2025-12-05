---@diagnostic disable: undefined-global
return {
	"lervag/vimtex",
	ft = { "tex" },
	init = function() 
		vim.g.tex_flavor = 'latex'
		vim.g.vimtex_view_method = 'zathura'
		vim.g.vimtex_quickfix_mod0 = 0
		vim.opt.conceallevel = 1 -- NOTE: maybe don't want this
		vim.g.tex_conceal = "abdmg"
	end
}
