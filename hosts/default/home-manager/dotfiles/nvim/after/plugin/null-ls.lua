local null_ls = require("null-ls")

null_ls.setup({
	on_attach = function(client, bufnr)
		local format_files = {
			"blade",
			"php",
			"javascript",
			"typescript",
			"typescriptreact",
			"lua",
			"cpp",
			"rust",
			"go",
			"vue",
			"elixir",
			"haskell",
			"python",
			"ocaml",
			"sql",
			"json",
		}

		if vim.tbl_contains(format_files, vim.bo.filetype) then
			require("lsp-zero").async_autoformat(client, bufnr)
		end
	end,

	sources = {
		null_ls.builtins.formatting.prettier,
		--null_ls.builtins.formatting.biome,
		null_ls.builtins.formatting.stylua,
		--null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.rustywind,
		null_ls.builtins.formatting.astyle,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.mix,
		null_ls.builtins.formatting.blade_formatter.with({ args = { "--write", "$FILENAME" } }),
		null_ls.builtins.formatting.brittany,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.ocamlformat,
		null_ls.builtins.formatting.pint,
		null_ls.builtins.formatting.sqlfluff.with({
			extra_args = { "--dialect", "sqlite" }, -- change to your dialect
		}),
		null_ls.builtins.formatting.fixjson,
	},
})
