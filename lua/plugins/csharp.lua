-- C# via Roslyn LSP. One-time setup:
--   :MasonInstall roslyn
-- The repo's global.json pins an SDK; install a matching one or Roslyn cannot load projects.
return {
	"seblyng/roslyn.nvim",
	ft = { "cs" },
	dependencies = { "mason-org/mason.nvim" },
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "cs",
			callback = function()
				if not pcall(vim.treesitter.start) then
					pcall(function() require("nvim-treesitter").install({ "c_sharp" }) end)
				end
			end,
		})
	end,
	config = function()
		vim.lsp.config("roslyn", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			settings = {
				["csharp|background_analysis"] = {
					-- Whole-solution analysis is too slow in a repo this large
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
				["csharp|completion"] = {
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_parameters = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = false,
				},
			},
		})

		require("roslyn").setup({
			-- Always use the main solution instead of prompting among the repo's many .sln files
			choose_target = function(targets)
				for _, target in ipairs(targets) do
					if target:match("D2L%.WebApp%.slnx$") then
						return target
					end
				end
				return nil
			end,
			filewatching = "roslyn",
		})
	end,
}
