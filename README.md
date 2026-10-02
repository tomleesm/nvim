# 安裝

## Neovim

``` bash
cd ~/apps
# 瀏覽器連到 https://github.com/neovim/neovim/releases/latest 顯示最新版本
# 抓取最新版本
wget https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
ln -s nvim-linux-x86_64.appimage nvim
# 編輯 ~/.bash_profile，加上  export PATH="$PATH:~/apps"
echo 'export PATH="$PATH:~/apps"' >> ~/.bash_profile
# 重新讀取 ~/.bash_profile 以啟用設定
source ~/.bash_profile
# 選項：sha256 checksum，和 GitHub 上的 sha256 比較
sha256sum nvim-linux-x86_64.appimage
```

## Nerd Fonts

1. 在 host 端，連到 [Nerd Fonts](https://www.nerdfonts.com/font-downloads)，搜尋 Symbols Only，點選 Download
2. 解壓縮後，滑鼠點兩下打開 SymbolsNerdFont-Regular.ttf 檔案，點選按鈕 install

## 設定

在 Neovim 執行指令 `:echo stdpath('config')`，會顯示預設設定檔目錄，例如在 Windows 10 是 C:\Users\Tom\AppData\Local\nvim，Linux 是 ~/.config/nvim

``` bash
mkdir -p ~/.config/
git clone git@github.com:tomleesm/nvim.git ~/.config/nvim
ln -s ~/.config/nvim/ ~/.nvim
```
