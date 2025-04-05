" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Core plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Autocompletion & LSP
Plug 'scrooloose/nerdtree'  " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git status in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Syntax highlighting for NERDTree
Plug 'ryanoasis/vim-devicons'  " File icons
Plug 'airblade/vim-gitgutter'  " Git diff in the gutter
Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy file finder
Plug 'scrooloose/nerdcommenter'  " Commenting support
Plug 'christoomey/vim-tmux-navigator'  " Seamless navigation between Vim and Tmux
Plug 'vim-airline/vim-airline'  " Status bar
Plug 'vim-airline/vim-airline-themes'  " Airline themes
Plug 'arcticicestudio/nord-vim'  " Nord theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'  " FZF integration
Plug 'tpope/vim-surround'  " Surround text with brackets, quotes, etc.
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'mbbill/undotree'  " Undo history visualization
Plug 'sheerun/vim-polyglot'  " Language support
Plug 'mhinz/vim-startify'  " Start screen
Plug 'nathanaelkane/vim-indent-guides'  " Indentation guides
Plug 'pechorin/any-jump.vim'  " Jump to symbols, words
Plug 'mhinz/vim-signify'  " Show changes in git
Plug 'LunarWatcher/auto-pairs'  " Auto pairs for brackets, quotes
Plug 'ghifarit53/tokyonight-vim'

" Initialize plugin system
call plug#end()

" Basic settings
set bg=dark
set hlsearch
set backspace=indent,eol,start
set guifont=DejaVu\ Sans:s12
set mouse=a
set ignorecase
set belloff=all
set foldmethod=indent
set relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab " Use spaces instead of tabs
set laststatus=2
set statusline+=%F
set hidden " Allow hidden buffers
set cmdheight=2 " Better display for messages
set updatetime=300 " Faster completion
set shortmess+=c " Don't pass messages to |ins-completion-menu|
set signcolumn=yes " Always show signcolumn
set termguicolors " Enable true colors

" colorscheme
colorscheme catppuccin_mocha

" Key mappings
let mapleader = " "
let g:mapleader = " "

" NERDTree mappings: Toggle NERDTree with space+e
nmap <space>e :NERDTreeToggle<CR>

" Close NERDTree if it's the last buffer
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif

" Automatically close NERDTree when opening a file
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | b# | endif

" Commenting
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Buffer navigation
nnoremap gb :ls<CR>:b<Space>

" Search and replace
nnoremap ge yiw:%s/<C-r>0//g<Left><Left>

" Window resizing
nnoremap <Leader>w+ :vertical resize +5<CR>
nnoremap <Leader>w- :vertical resize -5<CR>
nnoremap <Leader>t :tabs<CR>

" Yank and paste to system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap <Leader>y "+y
vmap <Leader>p "+p

" Terminal escape
tnoremap <Esc> <C-\><C-n>

" FZF mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Coc.nvim settings
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-clangd',
  \ 'coc-java',
  \ ]

" Use Tab for completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use Shift-Tab to navigate backward in completion menu
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go-to definitions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Formatting
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)

" NERDTree settings
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" Highlight yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
augroup END

" Source configuration
command! ReloadConfig source ~/.vimrc
