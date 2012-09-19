" File:        fortuneod.vim
"
" Description: Fortune on demand creates a bottom (by default) horizontal
"              split window with the result of the unix fortune command.
"
" Maintainer:  Yann Thomas-Gérard <inside at gmail dot com>
" Version:     1.0
" License:     This file is placed in the public domain.

" Load guard
if exists("g:loaded_fortuneod")
    finish
endif

let g:loaded_fortuneod = 1

if !exists("g:fortuneod_botright_split")
    let g:fortuneod_botright_split = 1
endif

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
    let l:botright_split = g:fortuneod_botright_split ? "botright" : "topleft"

    " Open a split window
    exec l:botright_split . ' split ' . a:bufName
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted

    return winnr()
endfunction

function s:GetContent()
    let l:content = []
    let l:content = split(system('fortune'), '\n')

    " exit codes detail: http://tldp.org/LDP/abs/html/exitcodes.html
    if v:shell_error != 0
        let l:content =  ["*Warning*", ""]

        if v:shell_error == 127
            let l:content += ["The fortune command was not found."]
            let l:content += ["You should probably install it with the command:", ""]
            let l:content += ["$ aptitude install fortune"]
        else
            let l:content += ["There was an error (" . v:shell_error . ") while executing the fortune unix command."]
        endif
    endif

    return l:content
endfunction
