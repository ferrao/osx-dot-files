set nocompatible
filetype off

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'othree/html5.vim'
Plug 'JulesWang/css.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhartington/oceanic-next'
Plug 'cocopon/iceberg.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/MatchTagAlways'
Plug 'ryanoasis/vim-devicons'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'tyok/nerdtree-ack'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } 
Plug 'mhinz/vim-startify'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-fugitive'
call plug#end()

" tab as 4 spaces or die
set ts=4 sw=4
set number
set mouse=a " we can actually select&copy with the mouse after this... 

" jsx
let g:jsx_ext_required = 1
let g:mta_filetypes = { 'javascript.jsx' : 1 }

" emmet-vim
"let g:user_emmet_leader_key='<C-M>'
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }

" linter
let g:ale_linters = {'javascript': ['eslint'], 'javascript.jsx': ['eslint'], 'json': ['eslint'] }
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" formatter
let g:neoformat_try_formatprg = 1

" fix code on save, requires prettier-eslint-cli
autocmd BufWritePre *.js,*.jsx,*.json Neoformat
" waiting for https://github.com/prettier/prettier-eslint/pull/194
"let g:neoformat_javascript_prettier = { 'exe': './node_modules/.bin/prettier-eslint', 'args': ['--stdin'], 'stdin': 1 }
autocmd BufWritePost *.js,*.jsx AsyncRun -post=checktime ./node_modules/.bin/prettier-eslint --write %

" file browser
nnoremap <silent> <Leader><Space> :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>f :NERDTreeFind<Enter>
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" theme
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
set background=dark
colorscheme iceberg
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:airline_theme='iceberg'
hi htmlTagName guifg=#c0c5ce ctermfg=251
hi htmlEndTag guifg=#c0c5ce ctermfg=251
hi Comment gui=italic cterm=italic term=italic
let g:javascript_plugin_jsdoc = 1

" code folding
set foldmethod=syntax
set foldcolumn=1
let javascript_fold=1
set foldlevelstart=99

" auto completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" multiple windows
set splitbelow " used by sp command
set splitright " used by vsp command 
" Faster move between windows using alt-dir keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Sane and fast window resize using alt-[+-<>], alt-_ is a common mistake :)
nnoremap <m-lt> :exe "vertical resize " . (winwidth(0) * 3/4)<CR>
nnoremap <m->> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <m-+> :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <m--> :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <m-_> :exe "resize " . (winheight(0) * 3/4)<CR>

" Fuzzy finder
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignore files in .gitignore

" Start screen
let g:startify_session_persistence = 1
let g:startify_fortune_use_unicode = 1
