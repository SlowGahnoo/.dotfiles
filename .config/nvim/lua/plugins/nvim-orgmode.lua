return {
	'nvim-orgmode/orgmode',
		config = function()
			require('orgmode').setup_ts_grammar()
			require('orgmode').setup()
		end
}
