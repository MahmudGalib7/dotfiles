" Plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}        " Autocompletion & LSP
Plug 'scrooloose/nerdtree'                            " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'                    " Git status in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'       " Syntax highlighting for NERDTree
Plug 'ryanoasis/vim-devicons'                         " File icons
Plug 'airblade/vim-gitgutter'                         " Git diff in gutter
Plug 'ctrlpvim/ctrlp.vim'                             " Fuzzy finder
Plug 'scrooloose/nerdcommenter'                       " Commenting
Plug 'christoomey/vim-tmux-navigator'                 " Vim-Tmux nav
Plug 'vim-airline/vim-airline'                        " Status bar
Plug 'vim-airline/vim-airline-themes'                 " Airline themes
Plug 'arcticicestudio/nord-vim'                       " Nord theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " FZF
Plug 'junegunn/fzf.vim'                               " FZF integration
Plug 'tpope/vim-surround'                             " Surround text
Plug 'tpope/vim-fugitive'                             " Git integration
Plug 'mbbill/undotree'                                " Undo tree
Plug 'sheerun/vim-polyglot'                           " Language support
Plug 'mhinz/vim-startify'                             " Start screen
Plug 'nathanaelkane/vim-indent-guides'                " Indent guides
Plug 'pechorin/any-jump.vim'                          " Jump to symbols
Plug 'mhinz/vim-signify'                              " Git signs
Plug 'LunarWatcher/auto-pairs'                        " Auto pairs
Plug 'ghifarit53/tokyonight-vim'                      " Theme
Plug 'catppuccin/vim'                                 " Theme
Plug 'SirVer/ultisnips'                               " Snippet engine
Plug 'honza/vim-snippets'                             " Snippet collection

call plug#end()

" Basic settings
set bg=dark
set termguicolors

set number relativenumber
set mouse=a
set clipboard=unnamedplus
set tabstop=2 shiftwidth=2 expandtab smarttab cindent
set hidden
set nowrap
set signcolumn=yes
set shortmess+=c
set updatetime=300
set noshowmode
set splitbelow splitright
set laststatus=2
set belloff=all
set backspace=indent,eol,start
set guifont=DejaVu\ Sans:s12

colorscheme catppuccin_mocha

" Enable highlight from LSP (semantic tokens)
let g:coc_enable_locationlist = 0
let g:coc_snippet_next = '<tab>'
let g:coc_default_semantic_highlight_groups = 1

" Pmenu = popup menu, PmenuSel = selected item
highlight Pmenu       guibg=#1e1e2e guifg=#cdd6f4
highlight PmenuSel    guibg=#89b4fa guifg=#1e1e2e gui=bold
highlight PmenuThumb  guibg=#45475a
highlight PmenuSbar   guibg=#313244
highlight NormalFloat guibg=#1e1e2e guifg=#cdd6f4
highlight CocMenuSel  guibg=#89b4fa guifg=#1e1e2e gui=bold

" Preview window for documentation
set completeopt=menuone,noinsert,noselect
set pumheight=12
set previewheight=8

" Slightly faster updatetime
set updatetime=250

" Transparent float border fix
highlight FloatBorder guifg=#89b4fa guibg=#1e1e2e

" Leader key
let mapleader=" "
let g:mapleader=" "

" NERDTree toggle
nmap <space>e :NERDTreeToggle<CR>

" Close NERDTree if last buffer
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif

" Auto close NERDTree on file open
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | b# | endif

" Comment toggle
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Buffer list
nnoremap gb :ls<CR>:b<Space>

" Search & replace
nnoremap ge yiw:%s/<C-r>0//g<Left><Left>

" Window resize
nnoremap <Leader>w+ :vertical resize +5<CR>
nnoremap <Leader>w- :vertical resize -5<CR>
nnoremap <Leader>t :tabs<CR>

" Clipboard yank/paste
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap <Leader>y "+y
vmap <Leader>p "+p

" Terminal escape
tnoremap <Esc> <C-\><C-n>

" FZF mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" UndoTree toggle
nnoremap <leader>u :UndotreeToggle<CR>

" Format and save on Ctrl+S
nnoremap <C-s> :call CocAction('format')<CR>:w<CR>
inoremap <C-s> <Esc>:call CocAction('format')<CR>:w<CR>a

" Coc.nvim extensions
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" TAB to confirm completion or expand snippets
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-y>" :
      \ UltiSnips#CanExpandSnippet() ? "<C-R>=UltiSnips#ExpandSnippet()<CR>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump'])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ coc#jumpable(-1) ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-jump-backward'])\<CR>" :
      \ "\<C-h>"

set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Confirm completion with <CR>
inoremap <expr> <cr> pumvisible() ? coc#pum#confirm() : "\<CR>"

" Diagnostics navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to definitions etc.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if index(['vim','help'], &filetype) >= 0
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Formatting selected code
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

" Reload config command
command! ReloadConfig source ~/.vimrc

