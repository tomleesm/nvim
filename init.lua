------------- PLUGIN BASE -------------
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
vim.keymap.set('n', 'g;', ',', { noremap = true } )
-- mouse menu disable, let copy & paste work
vim.opt.mouse = ''

require("lazy").setup({
    {
      "kepano/flexoki-neovim",
      name = "flexoki"
    },
    {
      "PhilRunninger/bufselect"
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true
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
    },
    {
      "lervag/wiki.vim"
    }
  }
)
------------- PLUGIN SETUP ------------
require("nvim-autopairs").setup({
  -- Don't add pairs if it already has a close pair in the same line
  enable_check_bracket_line = false,
  -- Don't add pairs if the next char is alphanumeric
  ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})
-- 啟用 chentoast/marks.nvim
require("marks").setup()
--- 設定 wiki 放在哪個目錄
vim.g.wiki_root = '~/Documents/wiki/content'
------------- TEXT FORMAT -------------
-- 使用 >> 命令縮排時，一次移動幾個 space
vim.opt.shiftwidth = 2

-- 依照 shiftwidth 的值決定折疊時幾個空格為一層
vim.opt.foldmethod = 'indent'
vim.opt.foldminlines = 0
-- open all fold when load file
vim.opt.foldlevel = 10
vim.opt.foldenable = true

-- Ctrl + J / K 向下/上一行
vim.keymap.set('n', '<C-j>', ':move +1<CR>', { noremap = true } )
vim.keymap.set('n', '<C-k>', ':move -2<CR>', { noremap = true } )

------------- ABBREVIATION ------------
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

-- Add semicolon or comma to end of line
vim.keymap.set(
  'n',
  '<LEADER>;',
  [[A;<Esc>]],
  { desc = 'Custom: Add semicolon to end of line' }
)

vim.keymap.set(
  'v',
  '<LEADER>;',
  ':s/\\([^;]\\)$/\\1;/<CR>:nohl<CR>',
  { desc = 'Custom: Add a semicolon to end of each line in visual selection excluding lines that already have semicolons' }
)

vim.keymap.set(
  'n',
  '<LEADER>,',
  [[A,<Esc>]],
  { desc = 'Custom: Add comma to end of line' }
)

vim.keymap.set(
  'v',
  '<LEADER>,',
  ':s/\\([^,]\\)$/\\1,/<CR>:nohl<CR>',
  { desc = 'Custom: Add a comma to end of each line in visual selection excluding lines that already have commas' }
)

------------- FILE MANAGER ------------
-- [b / ]b 切換上一個 buffer / 下一個 buffer
vim.keymap.set('n', '[b', ':bprev<CR>', { noremap = true } )
vim.keymap.set('n', ']b', ':bnext<CR>', { noremap = true } )
-- <SPACE> 顯示 buffer list
vim.keymap.set('n', '<SPACE>', ':ShowBufferList<CR>', { noremap = true } )
-- Netrw
-- 顯示為樹狀結構
vim.g.netrw_liststyle = 3
-- 不顯示 banner
vim.g.netrw_banner = 0

-- 自動儲存檔案
vim.cmd('autocmd TextChanged,InsertLeave <buffer> silent write')
-- 離開 Neovim 時，儲存或更新 Session.vim
-- vim.cmd('autocmd VimLeave * mksession!')

-- 設定 path 為 Laravel 的資料夾，方便用 :find 打開檔案
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.opt.path:append({
      'app/**',
      'resources/**',
      'routes/**',
      'bootstrap/**',
      'database/**',
      'tests/**',
      'config/**',
      'storage/**'
    })
  end
})

------------- THEME -------------------
vim.cmd.colorscheme("flexoki-dark")
-- 顯示行數
vim.opt.number = true
-- 為了左邊的行數能有不同的顏色，所以顯示 cursor line
vim.opt.cursorline = true
-- 前景文字改成白色，背景色改成黑色
vim.api.nvim_set_hl(0, "Normal", { fg = white, bg = black } )
--<LEADER> / turn off search highlighting
vim.keymap.set('n', '<LEADER>/', ':nohl<CR>')
-- 提示超過 80 個字元
-- 如果想改顏色，加上底下這一行，結尾不用加逗號：
-- highlight ColorColumn guibg=red
vim.cmd([[
  call matchadd('ColorColumn', '\%81v', 100)
]])
-- 避免 syntax highlight 消失
vim.cmd('autocmd BufEnter * syntax sync fromstart')

-- 自訂狀態列
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/status_line.lua')

------------- TERMINAL -------------------
-- To map <Esc> to exit terminal-mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true } )

-- 按下 F4，執行 python 程式，並且使用 neovim 內建的 terminal 顯示結果 (使用 ChatGPT 生成)
-- 全域變數，記住 terminal buffer
local term_buf = nil

vim.keymap.set("n", "<F4>", function()
  local file = vim.fn.expand("%")
  if file == "" then
    print("No file")
    return
  end

  -- 如果 terminal buffer 不存在或已被關閉 → 重建
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
  else
    -- 找到已存在的 terminal window
    local found = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == term_buf then
        vim.api.nvim_set_current_win(win)
        found = true
        break
      end
    end

    -- 如果 buffer 還在但 window 不在 → 重新開一個 window 顯示它
    if not found then
      vim.cmd("vsplit")
      vim.cmd("wincmd l")
      vim.api.nvim_win_set_buf(0, term_buf)
    end
  end

  -- 傳送指令到 terminal
  local job_id = vim.b.terminal_job_id
  if job_id then
    vim.fn.chansend(job_id, "clear\n")
    vim.fn.chansend(job_id, "python3 " .. file .. "\n")
    vim.cmd("wincmd h")
  end

end, { noremap = true, silent = true })
