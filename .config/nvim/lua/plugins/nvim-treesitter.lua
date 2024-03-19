return {
	'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
			  highlight = {
			    enable = true,
			    additional_vim_regex_highlighting = {'org'},
			  },
			  ensure_installed = {
				  'c', 'cpp', 'rust', 'lua', 'python','org','typescript', 'javascript', 'css'}, -- Or run :TSUpdate org
			  sync_install = false
			}
		end
}
