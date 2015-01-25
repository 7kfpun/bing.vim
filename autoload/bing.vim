" bing.vim - Search bing in Vim
" Maintainer: kf <7kfpun@gmail.com>

scriptencoding utf-8


function! bing#CleanHtml(string)
    let string = a:string
    let string = substitute(string, "<[^>]*>", "", "g")
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
        let dom = webapi#xml#parse(response.content)

        let results = []
        for li_element in dom.findAll('li', {'class': 'b_algo'})
            let result = {}
            let heading = bing#CleanHtml(li_element.find('h2').toString())
            let url = li_element.find('a').attr['href']
            let body = bing#CleanHtml(li_element.find('p').toString())
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


function! bing#BingLines() range
    return bing#Bing(join(getline("'<", "'>"), ''))
endfunction
