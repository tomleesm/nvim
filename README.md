## 安裝

在 Neovim 執行指令 `:echo stdpath('config')`，會顯示預設設定檔目錄，例如在 Windows 10 是 C:\Users\Tom\AppData\Local\nvim，Linux 是 ~/.config/nvim

## 外掛 preservim/vim-markdown

[官方文件](https://github.com/preservim/vim-markdown/blob/master/doc/vim-markdown.txt)在此，不過是英文的，中文介紹在[絕世好 Vim：舒爽地編輯 Markdown 文件](https://fokayx.com/2018/01/21/markdown-extension-on-vim.html)

會用到的指令：

### Folding

- `zr`: reduces fold level throughout the buffer
- `zR`: opens all folds
- `zm`: increases fold level throughout the buffer
- `zM`: folds everything all the way
- `za`: toggle a fold your cursor is on
- `zA`: toggle a fold your cursor is on recursively
- `zo`: open a fold your cursor is on
- `zO`: open a fold your cursor is on recursively
- `zc`: close a fold your cursor is on
- `zC`: close a fold your cursor is on recursively

### 跳轉標題

- `]]`:前往下一個 header
- `[[`:前往上一個 header
- `][`:前往上一個同層級 header
- `[]`:前往下一個同層級 header
- `]c`:前往目前所在段落的 header
- `]u`:前往目前所在段落的母層級 header，也就是在 h3 段落中會跳到所屬的 h2 header

### 其他


`:HeaderDecrease`

將所有標題各升一級，例如 h2 `->` h1，在文件中已有設定 h1 的時候無法使用。如果有選取文件中的範圍，就只會作用在該選取範圍內。

`:HeaderIncrease`

將所有標題各降一級，例如 h3 `->` h4，如果有設定 h6 會無法使用。

`:Toc`

將視窗垂直切割顯示所有 header 的目錄列表，在任一 header 上按 enter 就可以直接跳至該標題。如果要跳到標題然後順便關閉 TOC 視窗，要再加上這行：

``` vim
nnoremap <expr><enter> &ft=="qf" ? "<cr>:lcl<cr>" : (getpos(".")[2]==1 ? "i<cr><esc>": "i<cr><esc>l")
```
`:Toch`

將視窗水平切割顯示所有 header 的目錄列表

`:Toct`

另外開啟一個分頁 Tab 顯示所有 header 的目錄列表
