" vim plugin file
" Filename:     protec.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.25
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_protec')
    finish
endif
let loaded_protec = 1

" check vim has required features
if !has('autocmd')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':ReProtect') != 2
    command -nargs=0 ReProtect call <SID>SetProtectorates()
endif

" constants {{{2
let s:protec_optvars = {
            \   'readonly':       'g:protec_readonly_paths',
            \   'nomodifiable':   'g:protec_nomodifiable_paths',
            \ }
lockvar s:protec_optvars

let s:str_delimiter = '\s*,\s*'
lockvar s:str_delimiter

" function {{{2
function! s:GetValueOfVar(varname)
    if !exists(a:varname)
        throw 'Not exist: ' . a:varname
    endif

    return eval(a:varname)
endfunction

function! s:Convert2String(src)
    " check the type
    let typeofsrc = type(a:src)
    if     typeofsrc ==# 1 " String
        return join(split(a:src, s:str_delimiter), ',')
    elseif typeofsrc ==# 3 " List
        return join(a:src, ',')
    elseif typeofsrc ==# 4 " Dictionary
        return join(values(a:src), ',')
    endif

    throw 'A String, a List or a Dictionary is required: ' . string(a:src)
endfunction

function! s:SetProtectorates()
    augroup protec
        autocmd! protec
    augroup END

    for [opt, var] in items(s:protec_optvars)
        try
            let paths = s:Convert2String(s:GetValueOfVar(var))
        catch
            continue
        endtry
        if !empty(paths)
            augroup protec
                execute 'autocmd' 'BufReadPost' paths 'setlocal' opt
            augroup END
        endif
    endfor
endfunction

" execute codes {{{2
call s:SetProtectorates()

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3