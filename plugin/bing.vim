" pypi - Search bing in Vim
" Maintainer: kf <7kfpun@gmail.com>

scriptencoding utf-8


if (exists("g:loaded_bing") && g:loaded_bing) || &cp
    finish
endif
let g:loaded_bing = 1


silent! call webapi#json#decode('{}')
if !exists('*webapi#json#decode')
    echohl ErrorMsg | echomsg "checkip.vim requires webapi (https://github.com/mattn/webapi-vim)" | echohl None
    finish
endif


function! s:check_defined(variable, default)
    if !exists(a:variable)
        let {a:variable} = a:default
    endif
endfunction


command! -nargs=+ BingRaw :echo bing#Bing(<f-args>)
command! -nargs=+ Bing :echo bing#BingResult(<f-args>)
command -range -nargs=0 BingLines :echo bing#BingLines()
