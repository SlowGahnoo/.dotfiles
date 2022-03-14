call plug#begin('~/.vim/plugged')
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
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
" Better C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" nvim-lspconfig
Plug 'neovim/nvim-lspconfig'
" nvim-cmp 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
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
call plug#end()

nnoremap <F5> :lua require("nabla").action()<CR>
nnoremap <leader>p :lua require("nabla").popup()<CR> 
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


  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
      files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
  }

  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      disable = {'org'},
      additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'}, -- Or run :TSUpdate org
  }

  require('orgmode').setup_ts_grammar()

EOF

"Live LaTeX Preview
let g:livepreview_previewer='zathura'
let g:livepreview_engine='xelatex'
let g:livepreview_cursorhold_recompile = 0

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

"autoclose tags
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap " ""<left>

let mapleader="\<Space>"

nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" Nerdtree conf
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-f> :NERDTreeToggle<CR>

set iminsert=0
set imsearch=-1"

" vim-cpp-enchanced-highlight settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1


