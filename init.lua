-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "," -- Same for `maplocalleader`

require("lazy").setup({
  -- theme flexoki
  {
    "kepano/flexoki-neovim", name = "flexoki"
  }, 
  {
    "PhilRunninger/bufselect"
  }
}
)
vim.cmd('colorscheme flexoki-dark')
-- 顯示行數
vim.o.number = true
-- 為了左邊的行數能有不同的顏色，所以顯示 cursor line
vim.o.cursorline = true
-- cursor line 只顯示左邊的數字，預設是 both(=number,line)
vim.o.cursorlineopt = "number"
-- 前景文字改成白色，背景色改成黑色
vim.api.nvim_set_hl(0, "Normal", { ctermfg=White,  ctermbg=Black })
-- <SPACE> 顯示 buffer list
vim.api.nvim_set_keymap('n', '<SPACE>', ':ShowBufferList<CR>', {noremap=true})
