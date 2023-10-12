return {
	'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'mfussenegger/nvim-dap-python',
		},
		config = function()
			require('dap')
			vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
			require('dap-python').setup('/usr/bin/python')
			
			require("dapui").setup({
			  icons = { expanded = "▾", collapsed = "▸" },
			  mappings = {
			    -- Use a table to apply multiple mappings
			    expand = { "<CR>", "<2-LeftMouse>" },
			    open = "o",
			    remove = "d",
			    edit = "e",
			    repl = "r",
			    toggle = "t",
			  },
			  -- Expand lines larger than the window
			  -- Requires >= 0.7
			  expand_lines = vim.fn.has("nvim-0.7"),
			  -- Layouts define sections of the screen to place windows.
			  -- The position can be "left", "right", "top" or "bottom".
			  -- The size specifies the height/width depending on position.
			  -- Elements are the elements shown in the layout (in order).
			  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
			  layouts = {
			    {
			      elements = {
			      -- Elements can be strings or table with id and size keys.
			        { id = "scopes", size = 0.25 },
			        "breakpoints",
			        "stacks",
			        "watches",
			      },
			      size = 40,
			      position = "right",
			    },
			    {
			      elements = {
			        "repl",
			        "console",
			      },
			      size = 10,
			      position = "bottom",
			    },
			  },
			  floating = {
			    max_height = nil, -- These can be integers or a float between 0 and 1.
			    max_width = nil, -- Floats will be treated as percentage of your screen.
			    border = "single", -- Border style. Can be "single", "double" or "rounded"
			    mappings = {
			      close = { "q", "<Esc>" },
			    },
			  },
			  windows = { indent = 1 },
			  render = {
			    max_type_length = nil, -- Can be integer or nil.
			  }
			})
			
			local extension_path = '/HDD/vscode_ext/extension/'
			local codelldb_path = extension_path .. 'adapter/codelldb'
			local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
			
			local dap = require('dap')
			dap.adapters.cppdbg = {
			  id = 'cppdbg',
			  type = 'executable',
			  command = '/usr/local/bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
			}
			
			
			dap.configurations.cpp = {
			  {
			    name = "Launch file",
			    type = "cppdbg",
			    request = "launch",
			    program = function()
			      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			    end,
			    cwd = '${workspaceFolder}',
			    stopOnEntry = true,
				setupCommands = {  
				  { 
				     text = '-enable-pretty-printing',
				     description =  'enable pretty printing',
				     ignoreFailures = false 
				  },
				},
			
			  },
			}
			
			
			
			dap.configurations.c = dap.configurations.cpp
			
			
			vim.cmd([[
			imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
			smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
			imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
			smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
			
			
			nnoremap <silent> <F5>       :lua require('dap').continue()<CR>
			nnoremap <silent> <leader>n  :lua require('dap').step_over()<CR>
			nnoremap <silent> <leader>si :lua require('dap').step_into()<CR>
			nnoremap <silent> <leader>so :lua require('dap').step_out()<CR>
			nnoremap <silent> <leader>b  :lua require('dap').toggle_breakpoint()<CR>
			nnoremap <silent> <leader>dr :lua require('dap').repl.toggle()<CR>
			nnoremap <silent> <leader>dd :lua require('dapui').toggle()<CR>
			]])


		end

}
