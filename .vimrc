if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'alvan/vim-closetag'
Plug 'vim-scripts/BufOnly.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'matze/vim-move'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

let g:onedark_terminal_italics=1
colorscheme onedark

" Custom configs
set termguicolors
let loaded_netrwPlugin = 1

filetype plugin on
syntax on

set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set mouse=a
set splitright
set splitbelow
set nofoldenable
set backupcopy=yes
set updatetime=300
set shortmess+=c
set signcolumn=yes
set iskeyword+=\-

hi Normal guibg=NONE ctermbg=NONE
hi Comment guifg=#A9A9A9 gui=italic
hi CursorLine guibg=#708090 guifg=#FFFFFF
hi Visual guibg=#708090 guifg=#FFFFFF

" Custom key mapping
nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-L> <C-W>l
nmap <C-H> <C-W>h
nmap <c-p> :FZF<CR>
nmap <c-f> :Ag<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>f :Format<CR>
nmap <leader>l :CocDiagnostics<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call <SID>show_documentation()<CR>
nmap <Leader>bo :BufOnly<CR>
xmap <leader>f  <Plug>(coc-format-selected)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <space>e :CocCommand explorer<CR>
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>
nmap <space>el :CocList explPresets<CR>

"scrooloose/nerdcommenter
let NERDDefaultAlign="left"
let NERDSpaceDelims=1

" junegunn/fzf.vim
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" alvan/vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" itchyny/lightline.vim#one 

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" neoclide/coc.nvim
let g:coc_global_extensions = [
     \ 'coc-explorer',
     \ 'coc-fzf-preview',
     \ 'coc-lists',
     \ 'coc-prettier',
     \ 'coc-eslint',
     \ 'coc-stylelint',
     \ 'coc-snippets',
     \ 'coc-emmet',
     \ 'coc-yank',
     \ 'coc-highlight',
     \ 'coc-tsserver',
     \ 'coc-python',
     \ 'coc-html',
     \ 'coc-json',
     \ 'coc-yaml',
     \ 'coc-markdownlint',
     \ 'coc-css',
     \ 'coc-svelte',
     \]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

command! -nargs=0 Format :call CocAction('format')
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

let g:coc_snippet_next = '<tab>'

" edkolev/tmuxline.vim

let g:tmuxline_theme = 'zenburn'
let g:tmuxline_preset = {
    \'a'    : '#S',
    \'win'  : ['#I', '#W'],
    \'cwin' : ['#I', '#W', '#F'],
    \'z'    : ' #(dirs -c; dirs)',
    \}

" Multi select
let g:multi_cursor_next_key='<C-n'
let g:multi_cursor_next_key='<C-p'
let g:multi_cursor_next_key='<C-x'

" matze/vim-move
let g:move_key_modifier = 's'

" coc-explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }
