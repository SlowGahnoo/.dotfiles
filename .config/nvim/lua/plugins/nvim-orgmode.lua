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
			org_default_notes_file ='~/orgfiles/refile.org',
			notifications = {
				enabled = false,
				cron_enabled = true,
				repeater_reminder_time = false,
				deadline_warning_reminder_time = false,
				reminder_time = {1, 5, 10},
				deadline_reminder = true,
				scheduled_reminder = true,
				notifier = function(tasks)
				  local result = {}
				  for _, task in ipairs(tasks) do
				    require('orgmode.utils').concat(result, {
				      string.format('# %s (%s)', task.category, task.humanized_duration),
				      string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
				      string.format('%s: <%s>', task.type, task.time:to_string())
				    })
				  end
				
				  if not vim.tbl_isempty(result) then
				    require('orgmode.notifications.notification_popup'):new({ content = result })
				  end
				end,
				cron_notifier = function(tasks)
				  for _, task in ipairs(tasks) do
					local icon = "~/.local/share/icons/Memphis98/mimetypes/scalable/text-calendar.png"
				    local title = string.format('%s (%s)', task.category, task.humanized_duration)
				    local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
				    local date = string.format('%s: %s', task.type, task.time:to_string())
				
				    -- Linux
				    if vim.fn.executable('dunstify') == 1 then
				      vim.loop.spawn('dunstify', { args = { '-i', icon, string.format('%s\n%s\n%s', title, subtitle, date) }})
				    end
				
				  end
				end

			}
		})
	end
}
