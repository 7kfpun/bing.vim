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
    if has('win32')
        " Target command: start "" "<url>"
        silent! execute "! " . g:bing_open_command . " \"\" \"" . a:url . "\""
    else
        silent! execute "! " . g:bing_open_command . ' "' . a:url . '" > /dev/null 2>&1 &'
    endif
endfunction


" Unite integration {{{
" =====================

    function! unite#sources#bing#define()
        return s:source
    endfunction

    function! s:source.hooks.on_init(args, context) "{{{
        if type(get(a:args, 0, '')) == type([])
            " Use args directly.
            let a:context.source__is_dummy = 0
            return
        endif

        let command = join(filter(copy(a:args), "v:val !=# '!'"), ' ')
        if command == ''
            let command = unite#util#input(
                        \ 'Please input Vim command: ', '', 'command')
            redraw
        endif
        let a:context.source__command = command
        let a:context.source__is_dummy = (get(a:args, -1, '') ==# '!')

        if !a:context.source__is_dummy
            call unite#print_source_message('command: ' . command, s:source.name)
        endif
    endfunction"}}}

    fun! s:source.gather_candidates(args, context) "{{{
        echo a:args

        " if type(get(a:args, 0, '')) == type([])
            " Use args directly.
            let query = join(a:args, ' ')
        " else
            " redir => output
            " silent! execute a:context.source__command
            " redir END

            " let query = split(output, '\r\n\|\n')
            " let query = 'test'
            " echo query
        " endif

        let results = bing#Bing(query)
        
        return map(results, "{
            \ 'word' : v:val.heading.'   '.v:val.body,
            \ 'url': v:val.url,
            \ 'cmd': ''
        \ }")
    endfun "}}}

    let s:source.action_table.execute = {'description' : 'play station'}
    fun! s:source.action_table.execute.func(candidate) "{{{
        echo a:candidate.url
        call s:open_browser(a:candidate.url)
    endfunction "}}}

    fun! s:source.hooks.on_syntax(args, context) "{{{
    endfunction "}}}

    fun! s:source.hooks.on_post_filter(args, context) "{{{
    endfunction "}}}

" }}}


let &cpo = s:save_cpo
unlet s:save_cpo
