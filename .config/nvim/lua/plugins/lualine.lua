return {
	'hoob3rt/lualine.nvim',
		config = function()	
			require('lualine').setup({
			  options = {
			    theme = 'sonokai', 
			    component_separators = {'|'},
			    section_separators = {''},
			  }
			})
		end
}
