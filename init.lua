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
-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ","
-- Same for `maplocalleader`
vim.g.maplocalleader = ","
-- 設定 g; 是原來的 ,
vim.api.nvim_set_keymap("n", "g;", ",", {noremap=true})

require("lazy").setup({
    {
      "kepano/flexoki-neovim", name = "flexoki"
    },
    {
      "PhilRunninger/bufselect"
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },
    {
      "chentoast/marks.nvim"
    },
    {
      "farmergreg/vim-lastplace"
    },
    {
      "masukomi/vim-markdown-folding"
    }
  }
)
vim.cmd("colorscheme flexoki-dark")
-- 顯示行數
vim.o.number = true
-- 使用 >> 命令縮排時，一次移動幾個 space
vim.opt_local.shiftwidth = 2
-- 按下 <Tab> 時改插入 space
vim.opt_local.expandtab = true
-- 按下 <Tab> 時插入幾個 space
vim.opt_local.softtabstop = 2
-- [b / ]b 切換上一個 buffer / 下一個 buffer
vim.api.nvim_set_keymap("n", "[b", ":bprev<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "]b", ":bnext<CR>", {noremap=true})
-- 為了左邊的行數能有不同的顏色，所以顯示 cursor line
vim.o.cursorline = true
-- 前景文字改成白色，背景色改成黑色
vim.api.nvim_set_hl(0, "Normal", { ctermfg=White, ctermbg=Black })
-- <SPACE> 顯示 buffer list
vim.api.nvim_set_keymap("n", "<SPACE>", ":ShowBufferList<CR>", {noremap=true})
-- 設定 autopairs
require("nvim-autopairs").setup({
  -- Don't add pairs if it already has a close pair in the same line
  enable_check_bracket_line = false,
  -- Don't add pairs if the next char is alphanumeric
  ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})
-- 啟用 chentoast/marks.nvim
require("marks").setup()

-- Netrw
-- 顯示為樹狀結構
vim.g.netrw_liststyle = 3
-- 不顯示 banner
vim.g.netrw_banner = 0

-- 自動儲存檔案
vim.cmd("autocmd TextChanged,InsertLeave <buffer> silent write")
-- 離開 Neovim 時，儲存或更新 Session.vim
vim.cmd("autocmd VimLeave * mksession!")

--<LEADER> / turn off search highlighting
vim.keymap.set("n", "<LEADER>/", ":nohl<CR>")
------------------------------
------- abbreviation ---------
------------------------------
vim.cmd([[
  iabbrev heigth height
  iabbrev hegiht height
  iabbrev heiht height
  iabbrev heigt height
  iabbrev weigth weight
  iabbrev wegiht weight
  iabbrev weiht weight
  iabbrev weigt weight
]])

-- 避免 syntax highlight 消失
vim.cmd('autocmd BufEnter * syntax sync fromstart')
-- mouse menu disable, let copy & paste work
vim.opt.mouse = ''
-- 確保外掛 masukomi/vim-markdown-folding 可用
vim.cmd('set foldmethod=expr')
