call plug#begin('~/.config/nvim/plugged')
" Vim dracula theme
Plug 'dracula/vim'
" Vim colorschemes
Plug 'flazz/vim-colorschemes'
" Vim icons
Plug 'ryanoasis/vim-devicons'
" Nerdtree
Plug 'scrooloose/nerdtree'
" Compare swap files
Plug 'chrisbra/Recover.vim'
" Convinient commenting
Plug 'tpope/vim-commentary'
" nvim-lspconfig
Plug 'neovim/nvim-lspconfig'
" nvim-cmp 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Friendly snippets
Plug 'rafamadriz/friendly-snippets'
" nvim orgmode
Plug 'nvim-orgmode/orgmode'
" nvim lualine
Plug 'hoob3rt/lualine.nvim'
" glsl highlight
Plug 'tikhomirov/vim-glsl'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Nabla - Take your scientific notes in Neovim
Plug 'jbyuki/nabla.nvim'
" Bracey - plugin for live html, css and javascript editing in vim
Plug 'turbio/bracey.vim', {'do': 'npm --prefix server'}

" Debug Adapter Protocol 
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'

Plug 'windwp/nvim-autopairs'
call plug#end()

let mapleader="\<Space>"

" nnoremap <F5> :lua require("nabla").action()<CR>
" nnoremap <leader>p :lua require("nabla").popup()<CR> 
" Customize with popup({border = ...})  : `single` (default), `double`, `rounded`

autocmd! BufNewFile,BufRead *.vs,*.fs,*.fragmentshader,*.vertexshader set ft=glsl

lua << EOF

  require('lualine').setup({
	options = {
	  theme = 'dracula', 
	  component_separators = {'|'},
	  section_separators = {''},
	}
  })

  require('nvim-autopairs').setup({
  })

  -- Setup nvim-cmp.
  local cmp = require'cmp'

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
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
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


  require('orgmode').setup_ts_grammar()

  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      disable = {'org'},
      additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'}, -- Or run :TSUpdate org
  }


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

EOF

" Jump forward or backward
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

" Enable mouse
set mouse=a

" Undo
set undofile

"Encoding
set encoding=utf-8
set fileencoding=utf-8

set ttimeoutlen=100

"Colorscheme
colorscheme dracula_bold
set termguicolors
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
autocmd BufWritePost init.vim source %

"Git gud map (disables arrow keys)
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

"Set relative numbers
set nu rnu

"Use system clipboard
set clipboard=unnamedplus

"Save me from misspressing shift
command! W :w
command! Q :q

"Tabs from 8 to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
"set expandtab

"Navigate by display lines instead of regular lines
noremap j gj
noremap k gk

"Switch splits quickly
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Open Terminal
nnoremap tt :split<Bar>terminal<CR>


nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" Nerdtree conf
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-f> :NERDTreeToggle<CR>

set iminsert=0
set imsearch=-1"
