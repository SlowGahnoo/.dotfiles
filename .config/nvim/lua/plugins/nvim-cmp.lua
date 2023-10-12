return {
	'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'hrsh7th/vim-vsnip-integ',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lua',
			'uga-rosa/cmp-dictionary',
			'rafamadriz/friendly-snippets',

		},
		config = function()
			local cmp = require'cmp'
			
			cmp.setup({
			  snippet = {
			    expand = function(args)
			      vim.fn["vsnip#anonymous"](args.body)
			    end,
			  },
			 
			  -- completion = {
			  -- 	completeopt = 'menu,menuone,noinsert',
			  -- 	autocomplete = false,
			  -- },
			
			  window = {
				  completion = cmp.config.window.bordered(),
				  documentation = cmp.config.window.bordered(),
			  },
			
			  mapping = {
			    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			    ['<C-f>'] = cmp.mapping.scroll_docs(4),
			    ['<C-Space>'] = cmp.mapping.complete(),
			    ['<C-e>'] = cmp.mapping.close(),
			    ['<CR>'] = cmp.mapping.confirm({ select = true, })
			  },
			
			  sources = {
			    { name = 'nvim_lua' },
			    { name = 'nvim_lsp' },
			    { name = 'vsnip' },
			    { name = 'buffer' },
			    { name = 'path' },
			    { name = 'dictionary', keyword_length = 2, max_item_count = 30 },
			    { name = 'orgmode' },
				{}
			  }
			})
			
			require("cmp_dictionary").setup({
			    dic = {
			        ["*"] = { "~/.config/nvim/dict/en.dict" },
			    },
			    -- The following are default values, so you don't need to write them if you don't want to change them
			    exact = 2,
			    first_case_insensitive = false,
			    document = false,
			    document_command = "wn %s -over",
			    async = true, 
			    capacity = 5,
			    debug = false,
			})
			
			capabilities = require('cmp_nvim_lsp').default_capabilities()

			local servers = {
			    'ccls', 
			    'rust_analyzer', 
			    'jedi_language_server', 
			    'tsserver', 
			    'html', 
			    'cssls',
				'matlab_ls'
			    }
			

			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			local opts = { noremap=true, silent=true }
			vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
			vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
			
			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
			  -- Enable completion triggered by <c-x><c-o>
			  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			
			  -- Mappings.
			  -- See `:help vim.lsp.*` for documentation on any of the below functions
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
			  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
			end

			for _, lsp in ipairs(servers) do
			    require('lspconfig')[lsp].setup {
			  	  on_attach = on_attach,
			  	  capabilities = capabilities,
			    }
			end

		end

}
