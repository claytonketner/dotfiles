syntax on  " Syntax highlighting
set ruler  " Show row/col info
set nu  " Row numbers

""" Tabs
set tabstop=4  " Set tab size to 4
set shiftwidth=4  " Set block indentation shifting
set expandtab  " Use spaces for indentation
set autoindent  " Match indentation of previous line
" Filetype-specific tab settings
autocmd FileType pp setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2

set splitbelow  " Create new sp's below
set splitright  " Create new vsp's to the right
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)  " Only put ruler on lines >80 cols
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
