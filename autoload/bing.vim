" bing.vim - Search bing in Vim
" Maintainer: kf <7kfpun@gmail.com>

scriptencoding utf-8


function! s:CleanHtml(string)
    let string = substitute(a:string, "<[^>]*>", "", "g")
    let string = webapi#html#decodeEntityReference(string)
    return string
endfunction
    

function! bing#Bing(...)

    let query = join(a:000, ' ')
    let query = substitute(query, '\s\{1,}', '%20', 'g')

    let request_uri = 'http://www.bing.com/search?q='.query
    echo 'Searching... '.request_uri
    try
        let response = webapi#http#get(request_uri)
        let g:dom = webapi#xml#parse(response.content)

        for li_element in g:dom.findAll('li', {'class': 'b_algo'})
            echo s:CleanHtml(li_element.find('h2').toString())
            echo li_element.find('a').attr['href']
            echo s:CleanHtml(li_element.find('p').toString())
            echo ''
        endfor

    catch
        echoerr 'Something wrong with the internet.'
    endtry

endfunction


function! bing#BingLines() range
    return bing#Bing(join(getline("'<", "'>"), ''))
endfunction

