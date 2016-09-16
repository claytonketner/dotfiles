syntax on  " Syntax highlighting
set ruler  " Show row/col info
set nu  " Row numbers
set backspace=2  " Sane backspace behavior

""" Tabs
set tabstop=4  " Set tab size to 4
set shiftwidth=4  " Set block indentation shifting
set expandtab  " Use spaces for indentation
set autoindent  " Match indentation of previous line
" Highlight if line is >80 cols
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" Filetype-specific tab settings
autocmd FileType text setlocal shiftwidth=2 tabstop=2
autocmd FileType pp setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab

set splitbelow  " Create new sp's below
set splitright  " Create new vsp's to the right
set laststatus=2  " Put info bar at bottom of screen
set hlsearch  " Highlight all matching search items
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Save backups to ~/.vim/tmp
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
set cursorline  " Highlight current line
set shellcmdflag=-ic  " Make vim shell interactive
" Plugin stuff
execute pathogen#infect()
autocmd BufWritePost *.py call Flake8()  " Run flake8 on save
let g:vim_json_syntax_conceal = 0  " Don't do cute quote hiding for json
