let s:save_cpo = &cpo
set cpo&vim

" Options {{{
" -------
let s:source = {
\   'action_table': {},
\   'default_action' : 'execute',
\   'hooks': {},
\   'name': 'bing',
\   'syntax': 'uniteSource__Bing'
\}
" }}}


if !exists("g:bing_open_command")
    if has("win32")
        let g:bing_open_command = "start"
    elseif substitute(system('uname'), "\n", "", "") == 'Darwin'
        let g:bing_open_command = "open"
    else
        let g:bing_open_command = "xdg-open"
    endif
endif


function! s:open_browser(url)
    echomsg 'Open: ' . a:url
    call xolox#misc#open#url(a:url)

    " if has('win32')
        " " Target command: start "" "<url>"
        " silent! execute "! " . g:bing_open_command . " \"\" \"" . a:url . "\""
    " else
        " silent! execute "! " . g:bing_open_command . ' "' . a:url . '" > /dev/null 2>&1 &'
    " endif
endfunction


let s:input_query = ''

" Unite integration {{{
" =====================

    function! unite#sources#bing#define()
        return s:source
    endfunction

    function! s:source.hooks.on_init(args, context) "{{{
        if !empty(a:args)
            return
        endif

        let s:input_query = unite#util#input('Bing search: ', '', '')
    endfunction"}}}

    fun! s:source.gather_candidates(args, context) "{{{
        if !empty(a:args)
            let query = join(a:args, ' ')
        else
            let query = s:input_query
        endif

        let results = bing#Bing(query)

        return map(results, "{
            \ 'word' : v:val.heading . '   ' . v:val.body,
            \ 'url': v:val.url,
            \ 'cmd': ''
        \ }")
    endfun "}}}

    let s:source.action_table.execute = {
                \ 'description' : 'narrow source',
                \ 'is_quit' : 0,
                \ }
    function! s:source.action_table.execute.func(candidate) "{{{
        call s:open_browser(a:candidate.url)
    endfunction"}}}

    " fun! s:source.hooks.on_syntax(args, context) "{{{
    " endfunction "}}}

    " fun! s:source.hooks.on_post_filter(args, context) "{{{
    " endfunction "}}}

" }}}


let &cpo = s:save_cpo
unlet s:save_cpo
