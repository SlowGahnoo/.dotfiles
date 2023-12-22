return {
	'neovim/nvim-lspconfig',
	'tikhomirov/vim-glsl',
	'sainnhe/sonokai',
	'h-hg/fcitx.nvim',
	-- {'simrat39/rust-tools.nvim',
	-- 	config = function()
	-- 		local rt = require('rust-tools')
	-- 		local r_opts = {
	-- 			server = {
	-- 				on_attach = on_attach,
	-- 				capabilities = capabilities,
	-- 			},
	-- 			tools = {
	-- 				inlay_hints = {
	-- 					auto = false,
	-- 					show_parameter_hints = false,
	-- 				},
	-- 			},
	-- 			dap = {
	-- 				adapter = require('rust-tools.dap').get_codelldb_adapter(
	-- 				     codelldb_path, liblldb_path)
	-- 			},
	-- 		}
	-- 		rt.setup(r_opts)
	-- 	end
	-- }
}

-- vim.cmd([[autocmd! BufNewFile,BufRead *.vs,*.fs,*.fragmentshader,*.vertexshader set ft=glsl]])
