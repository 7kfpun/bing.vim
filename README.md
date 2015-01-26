# bing.vim

Simple plugin for quickly searching bing in Vim.

# Requirements

- [webapi-vim][]
- [unite.vim][] *(Optional for Unite.vim integration)*
- [vim-misc][] *(Optional for Unite.vim integration)*

# Usage

    // Without Unite.vim
    :Bing <query>  // Bing search the input query
    :'<,'>BingLines  // Bing search the selected lines

    // With Unite.vim
    :Unite bing
    :Unite bing:<query>

[webapi-vim]: https://github.com/mattn/webapi-vim
[unite.vim]: https://github.com/Shougo/unite.vim
[vim-misc]: https://github.com/xolox/vim-misc
