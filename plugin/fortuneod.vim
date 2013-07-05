" File:        fortuneod.vim
"
" Description: Fortune on demand creates a bottom (by default) horizontal
"              split window with the result of the unix fortune command.
"
" Maintainer:  Yann Thomas-Gérard <inside at gmail dot com>
" Version:     1.0.0
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
    nmap <Leader>F <Plug>FortuneodStart
endif

nnoremap <script> <Plug>FortuneodStart <SID>Start
nnoremap <silent> <SID>Start :call fortuneod#Start()<CR>
