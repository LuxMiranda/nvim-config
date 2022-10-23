" What is this shenanigans with the new Y mapping
unmap Y

" The color scheme for a true DOVAHKIIN 
":color alduin
:colorscheme sublimemonokai
":let g:sublimemonokai_term_italic = 1

" 80-character line
:set cc=80


" Fix paren/bracket matching highlights
":let g:alduin_Shout_Aura_Whisper = 1

" Some magic for syntax plugins like Haskell-Vim and Syntastic
syntax on

:set number

" I'm a fan of highlighted current lines
:set cursorline

" Sane indentation
:filetype on
filetype plugin indent on
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Fix for Haskell indentation
autocmd FileType haskell setlocal smartindent

" Fix for Markdown indentation
au FileType markdown setl sw=4 sts=4 et

nnoremap H J

" Better scrolling 
set scrolloff=999
set noshowcmd noruler
set mouse=a
nnoremap j gj
nnoremap k gk
nnoremap <silent> <C-j> :call comfortable_motion#flick(100) <CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" Autocorrect spelling mistake to first choice
nnoremap z1 z=1<CR><CR>

" NERD Tree hotkey
map <C-m> :NERDTreeToggle<CR>

" Make command
map <C-c> :make!<CR>

" Encapsulate in quotes
"map <C-q> :s/[^,]\+/"\0"/g <CR>


function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " Equation definition. Look for "\begin{equation}[anything]\end{equation}"
    syn region math start='\\begin' end='\\end'

    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Auto recompilation of markdown files with F3
autocmd FileType markdown nmap <F3> <ESC>:w<CR> :!pand '%:t'<CR>:redraw<CR>

" Enable spellcheck
:set spell 
hi clear SpellBad
hi SpellBad cterm=underline

" Add writing mode command and shortcut
:command WriteMode Goyo 80 | PencilSoft
map <C-p> :WriteMode<CR>

autocmd FileType python :hi semshiSelected ctermfg=231 ctermbg=235 cterm=bold
hi Comment ctermfg=243 cterm=italic
hi MatchParen ctermfg=231 ctermbg=235 cterm=bold

" Semshi commands
nmap <silent> <Tab> :Semshi goto name next<CR>
nmap <silent> <S-Tab> :Semshi goto name prev<CR>
nmap <silent> <leader>rr :Semshi rename<CR>

function! PyCommentChunk()
  let colnum = col('.')
  let lineNum = line('.')
  :normal j
  :exe (":normal " . colnum . "i#")
  :exe cursor(lineNum,colnum+1)
endfunction

nmap <silent> <leader>c :execute PyCommentChunk()<CR>

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

autocmd BufRead,BufNewFile,BufEnter *.nlogo,*.nls set filetype=netlogo nospell
" Pathogen load
execute pathogen#infect()
