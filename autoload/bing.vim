" bing.vim - Search bing in Vim
" Maintainer: kf <7kfpun@gmail.com>

scriptencoding utf-8


function! s:CleanHtml(string)
    let string = a:string
    let string = substitute(a:string, "<[^>]*>", "", "g")
    let string = webapi#html#decodeEntityReference(string)
    return string
endfunction
    

function! bing#Bing(...)

    let request_uri = 'http://www.bing.com/search?q='.join(a:000, '%20')
    echo request_uri
    try
        let response = webapi#http#get(request_uri)
        let g:dom = webapi#xml#parse(response.content)

        let results = []
        for li_element in g:dom.findAll('li', {'class': 'b_algo'})
            let result = {}
            let heading = s:CleanHtml(li_element.find('h2').toString())
            let url = li_element.find('a').attr['href']
            let body = s:CleanHtml(li_element.find('p').toString())
            let result.heading = heading
            let result.url = url
            let result.body = body
            " echo result
            call add(results, result)
        endfor

        return results

    catch
        echoerr 'Something wrong with the internet.'
    endtry

endfunction


function! bing#BingLines(...)
    echo 'Bing lines'
endfunction
