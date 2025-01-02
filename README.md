## 安裝

在 Neovim 執行指令 `:echo stdpath('config')`，會顯示預設設定檔目錄，例如在 Windows 10 是 C:\Users\Tom\AppData\Local\nvim，Linux 是 ~/.config/nvim

外掛 [nvim-orgmode/orgmode](https://github.com/nvim-orgmode/orgmode) 會用到外掛 [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)，Requirements 寫著：

> A C compiler in your path and libstdc++ installed ([Windows users please read this!](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)).

我選擇安裝 zig

``` bash
scoop install zig
```

然後開啟 neovim，執行指令 `:TSInstall c` 和 `:TSInstall cpp`
