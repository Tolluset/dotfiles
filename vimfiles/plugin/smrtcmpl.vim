" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/16 16:47:58.
" Version:      0.31
" Remark:       function that return keys to activate complete depending to
"               the situation.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_smrtcmpl')
    finish
endif
let loaded_smrtcmpl = 1

" check vim has required features
if !has('insert_expand')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
function! SmartComplete()
    " select next item if completion window is exist
    if pumvisible()
        return "\<C-n>"
    endif

    if &omnifunc != ''
        " omni completion
        return "\<C-x>\<C-o>"
    elseif &filetype == 'vim'
        " vim functions, special variables etc
        return "\<C-x>\<C-v>"
    elseif &filetype == 'perl'
        " perl has a lot of included files...
        return "\<C-n>"
    else
        " keyword completion(only in current buffer and included files)
        return "\<C-x>\<C-i>"
    endif
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
