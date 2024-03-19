return {
	'nvim-orgmode/orgmode',
	dependencies = {
		{ 'nvim-treesitter/nvim-treesitter', lazy = true },
	},
	config = function()
		require('orgmode').setup_ts_grammar()

		require('nvim-treesitter.configs').setup({
			highlight = {
				enable = true
			},
			ensure_installed = { 'org' },
		})

		require('orgmode').setup({
			org_agenda_files = '~/orgfiles/**/*',
			org_default_notes_file ='~/orgfiles/refile.org'
		})
	end
}
