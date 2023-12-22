return {
	'rcarriga/nvim-notify',
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup()

	end
}
