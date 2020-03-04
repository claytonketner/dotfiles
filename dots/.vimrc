syntax on  " Syntax highlighting
set background=light  " Use colors I like
set ruler  " Show row/col info
set number relativenumber  " Hybrid row numbers
set backspace=2  " Sane backspace behavior
set noesckeys  " Disable arrow keys in insert mode, which prevents the delay when using o/O to insert a new line

""" Tabs
set tabstop=4  " Set tab size to 4
set softtabstop=4  " Treat space tabs like normal tabs
set shiftwidth=4  " Set block indentation shifting
set expandtab  " Use spaces for indentation
set autoindent  " Match indentation of previous line
" Highlight if line is >100 cols
autocmd FileType python match Error /\%>99v.\+/
" Filetype-specific tab settings
autocmd FileType text setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.pp set ft=pp syntax=conf
autocmd FileType pp setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType sh setlocal shiftwidth=4 tabstop=4 noexpandtab

let g:netrw_list_hide = '\.DS_Store,\.pyc$'

""" Navigation, search
set splitbelow  " Create new sp's below
set splitright  " Create new vsp's to the right
set laststatus=2  " Put info bar at bottom of screen
set hlsearch  " Highlight all matching search items
set incsearch  " Show search results as you type
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Save backups to ~/.vim/tmp
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
set cursorline  " Highlight current line
"set shellcmdflag=-ic  " Make vim shell interactive
" Plugin stuff
execute pathogen#infect()
let g:vim_json_syntax_conceal = 0  " Don't do cute quote hiding for json
