## 安裝

在 Neovim 執行指令 `:echo stdpath('config')`，會顯示預設設定檔目錄，例如在 Windows 10 是 C:\Users\Tom\AppData\Local\nvim，Linux 是 ~/.config/nvim

### 使用 wiki 和 wikip 直接進入 wiki 模式

``` bash
echo 'alias wiki="nvim -S ~/.config/nvim/wiki-root.vim"' >> ~/.bash_profile
echo 'alias wikip="nvim -S ~/.config/nvim/wiki-root-private.vim"' >> ~/.bash_profile
```
