function fortuneod#Start() " {{{
    let l:bufName = "-fortuneod-"
    let l:content = fortuneod#GetContent()
    let l:winHeight = len(l:content) + 1

    if bufname('^' . l:bufName . '$') == ''
        call fortuneod#CreateWindow(l:bufName)
        nnoremap <buffer> n :call fortuneod#Start()<cr>
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

    execute 'resize ' . l:winHeight

    return append(0, l:content)
endfunction
" }}}

function fortuneod#CreateWindow(bufName) " {{{
    let l:botright_split = g:fortuneod_botright_split ? "botright" : "topleft"

    " Open a split window
    execute l:botright_split . ' split ' . a:bufName
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted

    return winnr()
endfunction
" }}}

function fortuneod#GetContent() " {{{
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
            let l:content += ["There was an error (" . v:shell_error . ") "]
            let l:content += ["while executing the fortune unix command."]
        endif
    endif

    return l:content
endfunction
" }}}
