## 安裝

在 Neovim 執行指令 `:echo stdpath('config')`，會顯示預設設定檔目錄，例如在 Windows 10 是 C:\Users\Tom\AppData\Local\nvim，Linux 是 ~/.config/nvim

``` bash
mkdir -p ~/.config/
git clone git@github.com:tomleesm/nvim.git ~/.config/nvim
ln -s ~/.config/nvim/ ~/.nvim
cd ~/.nvim
# 顯示所有分支，包含遠端分支
git branch -a
# 新增本地分支 tomleesm，並連結到遠端分支 origin/tomleesm
git branch --set-upstream-to=origin/tomleesm tomleesm
# 或是這個指令也可以
git checkout --track origin/tomleesm
```

## 分支

使用不同分支分別不同的設定

- ide-mvim: [MVIM](https://gitlab.com/domsch1988/mvim)
- ide-nvchad: [NvChad](https://nvchad.com/)
- main: 沒有外掛和設定的 neovim 預設狀態
- mini.nvim: [mini.nvim](https://github.com/echasnovski/mini.nvim)
- tomleesm: 我的原先設定，參考[部落格文章](https://github.com/tomleesm/blog/issues/15)
