" Colors definition
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=cyan ctermbg=236 guibg=#303030 guifg=#8fbfdc
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=001 ctermbg=236 guibg=#303030 guifg=#d75f5f
hi NormalColor guifg=Black guibg=Green ctermbg=46 ctermfg=0
hi InsertColor guifg=Black guibg=Cyan ctermbg=51 ctermfg=0
hi VisualColor guifg=Black guibg=Orange ctermbg=202 ctermfg=0
hi DefaultColor guifg=Black guibg=maroon1 ctermbg=165 ctermfg=0

" Mode codes and their names
let g:currentmode={
            \ 'n'  : 'NORMAL',
            \ 'no' : 'NORMAL·OPERATOR PENDING',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'V·LINE',
            \ "\<c-V>" : 'V·BLOCK',
            \ 's'  : 'SELECT',
            \ 'S'  : 'S·LINE',
            \ "<c-S>" : 'S·BLOCK',
            \ 'i'  : 'INSERT',
            \ 'R'  : 'REPLACE',
            \ 'Rv' : 'V·REPLACE',
            \ 'c'  : 'COMMAND',
            \ 'cv' : 'VIM EX',
            \ 'ce' : 'EX',
            \ 'r'  : 'PROMPT',
            \ 'rm' : 'MORE',
            \ 'r?' : 'CONFIRM',
            \ '!'  : 'SHELL',
            \ 't'  : 'TERMINAL'
            \}

function! GetStatusLine()
    let l:sl=""

    if (mode() =~# '\v(n|no)')
        let l:mc="%#NormalColor#"
    elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·BLOCK')
        let l:mc="%#VisualColor#"
    elseif (mode() ==# 'i')
        let l:mc="%#InsertColor#"
    else
        let l:mc="%#DefaultColor#"
    endif

    " Left side
    let l:sl=l:sl . l:mc                                          " Set the next element color per mode
    let l:sl=l:sl . "\ %{g:currentmode[mode()]}\ "                " The current mode
    let l:sl=l:sl . "%1*\ %<%F\ "                                 " File path
    let l:sl=l:sl . "%3*│"                                        " Separator
    let l:sl=l:sl . "%4*%M%r"                                     " Modified & Readonly flags

    " Right Side
    let l:sl=l:sl . "%="
    let l:sl=l:sl . "%2*\ %Y"                                     " File type
    let l:sl=l:sl . "%3*│"                                        " Separator
    let l:sl=l:sl . "%1*\ %{''.(&fenc!=''?&fenc:&enc).''}"        " File encoding
    let l:sl=l:sl . "\ [%{&ff}]\ "                                " File format
    let l:sl=l:sl . l:mc                                          " Set the next element color per mode
    let l:sl=l:sl . "\ ≡\ %02l/%L\ :\ %02v\ [%3p%%]"              " Line number / Total lines : Column number [Percentage of the document]

    return l:sl
endfunction

set laststatus=2
set noshowmode
set statusline=%!GetStatusLine()
