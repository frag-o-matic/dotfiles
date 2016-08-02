" voodoo for runtimepath & $HOME location on Windows
if has("win16") || has("win32") || has("win64")
    let $VIMHOME = $HOME."/nvimfiles"
    
    "runtimepath hacks for on windows
    let g:my_vim_dir=expand("$HOME/.nvim")
    execute "set rtp^=".g:my_vim_dir
    execute "set rtp+=".g:my_vim_dir."\\after"
    let &rtp=substitute(&rtp,"[/]","\\","g")

    "if called from cygwin change shell to cmd.exe 
    if &shell=~#'bash$'
        set shell=$COMSPEC " sets shell to correct path for cmd.exe
    endif
else
    let $VIMHOME = $HOME."/.nvim"
endif

" Get plugin manager up
call plug#begin('~/.nvim/plugged')
Plug 'romainl/Apprentice'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'vim-scripts/gtags.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'mhinz/vim-grepper'
Plug 'Mizuchi/STL-Syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tomtom/tcomment_vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/VimFold4C'
Plug 'lyuts/vim-rtags'
Plug 'ashwinravianandan/vimNotes'
Plug 'majutsushi/tagbar'
Plug 'wellle/targets.vim'
Plug 'ronakg/quickr-cscope.vim'
call plug#end()

" get the basic settings
so $VIMHOME/nvimrc_minimal

" get lightline config
so $VIMHOME/sourceables/lightline-config.vim

" compiler settings
so $VIMHOME/sourceables/compiler-settings.vim
nnoremap <F5> :silent make!\|redraw!\|copen<CR>

" set color scheme
colorscheme apprentice

" add project headers
" set path+= ~/testheaders

" autocomplete with rtags settings
let g:rtagsUseLocationList = 0  " Use QuickFix to display results
set completefunc=RtagsCompleteFunc

" terminal stuff
if has('nvim')
    " ESC to get into normal mode for term buffers
    tnoremap <Esc> <C-\><C-n>
    " Ctrl+Shift+key to navigate between splits
    tnoremap <C-S-h> <C-\><C-n><C-w>h
    tnoremap <C-S-j> <C-\><C-n><C-w>j
    tnoremap <C-S-k> <C-\><C-n><C-w>k
    tnoremap <C-S-l> <C-\><C-n><C-w>l
    nnoremap <C-S-h> <C-w>h
    nnoremap <C-S-j> <C-w>j
    nnoremap <C-S-k> <C-w>k
    nnoremap <C-S-l> <C-w>l
endif

"wildignore for vim & CtrlP
set wildignore+=*.so,*.swp,*.zip,*.pdf,*.dll,*.exe,*.out,*.o,*.a,*.lo,*.la,*.doc,*.ppt,*.docx,*.pptx,*.xls,*.xlsx

" Make Ctrl+P indexing faster by using ag silver searcher
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 0
"let g:ctrlp_working_path_mode = 'wa'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"Grepper Config
let g:grepper = {
    \ 'tools': ['ucg', 'ag', 'grep'],
    \ 'ucg': {
    \   'grepprg': 'ucg -iRQ --nocolor --jobs=8 --type-set=type1\:ext\:c,cpp,cxx,h,hpp,hxx,xml,am $* .',
    \   'grepformat': '%f:%l:%m',
    \   'escape':     '\+*^$()[].',
    \ }}

if executable("ucg")
   nnoremap <leader>g :Grepper -tool ucg -open -switch -query<CR> 
else
    nnoremap <leader>g :Grepper -tool grep -open -switch -query<CR> 
endif

" Make Ctrl+P matching faster by using pymatcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Add Buffer Mapping for CtrlP
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" indentLine settings
let g:indentLine_bufNameExclude         = ['_.*', 'NERD_tree.*', 'unite-.*']
let g:indentLine_leadingSpaceChar       = '·'
let g:indentLine_char                   = '|'
let g:indentLine_indentLevel            = 20
let g:indentLine_leadingSpaceEnabled    = 0

" vim-bookmarks settings
let g:bookmark_sign                 = '~~'
let g:bookmark_annotation_sign      = '##'
let g:bookmark_auto_save            = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save_file       = $VIMHOME .'/.saved-vim-bookmarks' 

" vim-bookmarks keymapping
nmap <Leader>j  <Plug>BookmarkNext
nmap <Leader>k  <Plug>BookmarkPrev

" UltiSnips Config
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-x>"
let g:UltiSnipsSnippetsDir=$VIMHOME.'/plugged/vim-snippets/UltiSnips'

" tags and cscope
set tags=./tags,tags;$VIMHOME/stl_tags

"gtags stuff
set csprg=gtags-cscope
" cscope add ./GTAGS,GTAGS,./cscope.out
set cscopetag
set csto=0
" set cscopeverbose
if filereadable("cscope.out")
    cs add cscope.out  
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" shortcuts to open files externally and perform online searches
if has('mac')
    let g:open_command = 'open'
elseif has('unix')
    let g:open_command = 'xdg-open'
else
    let g:open_command = 'start'
endif

command! -nargs=+ -complete=file_in_path Open call system(g:open_command.' <args>')
command! -nargs=+ Google call system(g:open_command.' "https://www.google.com/search?q=<args>"')
command! -nargs=+ Dict call system(g:open_command.' "http://dict.leo.org/?lp=ende&search=<args>"')
command! -nargs=+ Wikipedia call system(g:open_command.' "http://en.wikipedia.org/wiki/Special:Search?search=<args>"')
noremap gx :execute! Open y/<C-R>"
