" File:        fortuneod.vim
" Description: "Fortune on demand" creates a window on top of all others
"              with the result of the unix fortune command.
"
"              <Leader>F invokes the plugin if it is not already mapped.
"              If you don't wan't <Leader>F, create your prefered map, for
"              example:
"
"              noremap ,f <Plug>FortuneodStart
"
"              Pressing n in the Fortune window will show another fortune.
"
" Maintainer:  Yann Thomas-Gérard <inside at gmail dot com>
" Version:     1.0
" License:     This file is placed in the public domain.

" Load guard
if exists("g:loaded_fortuneod")
    finish
endif

let g:loaded_fortuneod = 1

if !hasmapto('<Plug>FortuneodStart')
    map <unique> <Leader>F <Plug>FortuneodStart
endif

noremap <unique> <script> <Plug>FortuneodStart <SID>Start
noremap <silent> <SID>Start :call <SID>Start()<CR>

function s:Start()
    let l:bufName = "-fortuneod-"
    let l:content = s:GetContent()
    let l:winSize = len(l:content) + 1

    if bufname('^' . l:bufName . '$') == ''
        call s:CreateWindow(l:bufName)
        noremap <buffer> <script> n <SID>Start
    else
        " Focus to fortuneod window
        execute bufwinnr('^' . l:bufName . '$') . "wincmd w"

        " Security:
        " If the buffer we are on is not the -fortuneod- buffer, we exit
        if bufname('%') != l:bufName
            echo "The fortuneod buffer was not found, exit."
            return 1
        endif

        " Refresh the window's content
        normal ggdG
    endif

    execute 'resize ' . l:winSize

    return append(0, l:content)
endfunction

function s:CreateWindow(bufName)
    " Open a split window
    exec 'topleft split ' . a:bufName
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted

    return winnr()
endfunction

function s:GetContent()
    let l:content = split(system('fortune'), '\n')

    return l:content
endfunction
