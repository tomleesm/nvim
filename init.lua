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
      "lukoshkin/highlight-whitespace",
      config=true,
    },
    {
      "cappyzawa/trim.nvim",
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons"
      }
    },
    {
      "chentoast/marks.nvim"
    },
    {
      "farmergreg/vim-lastplace"
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
-- [空白鍵 / ]空白鍵，往上新增一行 / 往下新增一行
vim.api.nvim_set_keymap("n", "[<SPACE>", "O<ESC>0Dj", {noremap=true})
vim.api.nvim_set_keymap("n", "]<SPACE>", "o<ESC>0Dk", {noremap=true})
-- 為了左邊的行數能有不同的顏色，所以顯示 cursor line
vim.o.cursorline = true
-- cursor line 只顯示左邊的數字，預設是 both(=number,line)
vim.o.cursorlineopt = "number"
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
-- 清空多餘的空格和空行
require("trim").setup({
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = { "markdown" },

  trim_on_write = false,
  -- 避免和 lukoshkin/highlight-whitespace 衝突
  -- 而且切換 buffer 後好像會失效？
  highlight = false
})
-- 設定 <LEADER><SPACE> 清空多餘的空格和空行
vim.api.nvim_set_keymap("n", "<LEADER><SPACE>", ":Trim<CR>", {noremap=true})
-- 自訂狀態列
dofile(os.getenv("HOME") .. "/.config/nvim/config/status_line.lua")
-- 啟用 chentoast/marks.nvim
require("marks").setup()

-- Netrw
-- 顯示為樹狀結構
vim.g.netrw_liststyle = 3
-- 不顯示 banner
vim.g.netrw_banner = 0

check_git_workspace = function()
  local filepath = vim.fn.expand('%:p:h')
  local gitdir = vim.fn.finddir('.git', filepath .. ';')
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end
-- 如果有 git 版本控制
if check_git_workspace() then
  -- 自動儲存檔案
  vim.cmd("autocmd TextChanged,InsertLeave <buffer> silent write")
  -- 離開 Neovim 時，儲存或更新 Session.vim
  vim.cmd("autocmd VimLeave * mksession!")
end

-- 設定 path 為 Laravel 的資料夾，方便用 :find 打開檔案
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function(args)
    vim.opt.path:append({
      "app/**",
      "resources/**",
      "routes/**",
      "bootstrap/**",
      "database/**",
      "tests/**",
      "config/**",
      "storage/**"
    })
  end
})
--<LEADER> / turn off search highlighting
vim.keymap.set("n", "<LEADER>/", ":nohl<CR>")
-- 提示超過 80 個字元
-- 如果想改顏色，加上底下這一行，結尾不用加逗號：
-- highlight ColorColumn guibg=red
vim.cmd([[
  call matchadd('ColorColumn', '\%81v', 100)
]])

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
  iabbrev f@ function
  autocmd FileType html,javascript,typescript,vue
   \ :iabbrev <buffer> log@ console.log();<Left><Left>
  iabbrev cl@ function (z) {}<Left><CR><Esc>?z<CR>xi
  autocmd FileType php
   \ :iabbrev <buffer> for@ for ( $i = 0; $i <z; $i++) {}<Left><CR><Esc>?z<CR>xi
  autocmd FileType php
   \ :iabbrev <buffer> fore@ foreach (z as $key => $value ) {}<Left><CR><Esc>?z<CR>xi
  autocmd FileType php
   \ :iabbrev <buffer> while@ while (z) {}<Left><CR><Esc>?z<CR>xi
  autocmd FileType php
   \ :iabbrev <buffer> ife@ if (z) {y} else {}<Left><CR><Esc>?y<CR>xi<CR><Esc>?z<CR>xi
]])

-- 避免 syntax highlight 消失
vim.cmd('autocmd BufEnter * syntax sync fromstart')
-- mouse menu disable, let copy & paste work
vim.opt.mouse = ''

-- Add semicolon or comma to end of line
vim.keymap.set(
  'n',
  '<leader>;',
  [[A;<Esc>]],
  { desc = 'Custom: Add semicolon to end of line' }
)

vim.keymap.set(
  'v',
  '<leader>;',
  ':s/\\([^;]\\)$/\\1;/<CR>:nohl<CR>',
  { desc = 'Custom: Add a semicolon to end of each line in visual selection excluding lines that already have semicolons' }
)

vim.keymap.set(
  'n',
  '<leader>,',
  [[A,<Esc>]],
  { desc = 'Custom: Add comma to end of line' }
)

vim.keymap.set(
  'v',
  '<leader>,',
  ':s/\\([^,]\\)$/\\1,/<CR>:nohl<CR>',
  { desc = 'Custom: Add a comma to end of each line in visual selection excluding lines that already have commas' }
)
