# bing.vim

Simple plugin for searching bing in Vim.

# Requirements

- [webapi-vim][]
- [unite.vim][] *(Optional)*

# Usage

    // Without Unite.vim
    :Bing <query>  // Bing search the input query
    :'<,'>BingLines  // Bing search the selected lines

    // With Unite.vim
    :Unite bing
    :Unite bing:<query>

[webapi-vim]: https://github.com/mattn/webapi-vim
[unite.vim]: https://github.com/Shougo/unite.vim
