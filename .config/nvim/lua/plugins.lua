vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/vim-vsnip-integ'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'rafamadriz/friendly-snippets'
	use 'f3fora/cmp-spell'
	use 'nvim-orgmode/orgmode'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/nvim-treesitter-refactor'
	use 'lewis6991/spellsitter.nvim'
	use {
		'turbio/bracey.vim',
		run = 'npm --prefix server'
	}
	use 'windwp/nvim-autopairs'
	use 'folke/which-key.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'hoob3rt/lualine.nvim'
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	use 'mfussenegger/nvim-dap-python'
	use 'terrortylor/nvim-comment'
	use {
	    'kyazdani42/nvim-tree.lua',
	    requires = {
	      'kyazdani42/nvim-web-devicons', -- optional, for file icon
	    }
	}
	use 'tikhomirov/vim-glsl'
	use 'ellisonleao/gruvbox.nvim'
end)

vim.cmd([[autocmd! BufNewFile,BufRead *.vs,*.fs,*.fragmentshader,*.vertexshader set ft=glsl]])

require('nvim-tree').setup({
	view = {
		relativenumber = true
	}
}) 
vim.api.nvim_set_keymap("n", "<c-f>", ":NvimTreeToggle<CR>", {noremap = true})

require('nvim_comment').setup()

require('lualine').setup({
  options = {
    theme = 'gruvbox', 
    component_separators = {'|'},
    section_separators = {''},
  }
})

require('colorizer').setup({
  css = {css = true;}
})

require('nvim-autopairs').setup()
require("which-key").setup()
require('orgmode').setup_ts_grammar()
require('orgmode').setup()

local cmp = require'cmp'

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {'org'},
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'c', 'cpp', 'lua', 'python','org'}, -- Or run :TSUpdate org
  sync_install = false
}

 require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = false,
    },
	smart_rename = {
		enable = true,
		keymaps = {
			smart_rename = "grr",
		},
	},
	navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
	},
  },
}



require('spellsitter').setup()


cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  
  completion = {
  	completeopt = 'menu,menuone,noinsert',
  	autocomplete = false,
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
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },

  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'spell' },
    { name = 'orgmode' },
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
    'clangd', 
    'rust_analyzer', 
    'jedi_language_server', 
    'tsserver', 
    'html', 
    'cssls',
    }

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
  	  on_attach = on_attach,
  	  capabilities = capabilities,
    }
end


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
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
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
})


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
