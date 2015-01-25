# bing.vim

Simple plugin for searching bing in Vim.

# Requirements

- [webapi-vim][]
- [unite.vim][] *(Optional)*

# Usage

    // Without Unite.vim
    :bing <query>
    :'<,'>BingLines

    // With Unite.vim
    :Unite bing
    :Unite bing:<query>

[webapi-vim]: https://github.com/mattn/webapi-vim
[unite.vim]: https://github.com/Shougo/unite.vim
