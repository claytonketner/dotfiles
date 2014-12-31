syntax on " Syntax highlighting
set ruler " Show row/col info
set nu " Row numbers
set tabstop=4 " Set tab size to 4
set shiftwidth=4 " Set block indentation shifting
set expandtab " Use spaces for indentation
set autoindent " Match indentation of previous line
set splitbelow " Create new sp's below
set splitright " Create new vsp's to the right
"set smartindent
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100) " Only put ruler on lines >80 cols
set laststatus=2 " Put info bar at bottom of screen
set hlsearch " Highlight all matching search items
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Save backups to ~/.vim/tmp
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
" Highlight current line
set cursorline
