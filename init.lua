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
vim.cmd('autocmd VimLeave * mksession!')

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
-- From https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
--------------------------------
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return vim.fn.mode()
  end,
  fmt = string.upper,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.green,
      i = colors.red,
      v = colors.blue,
      ['␖'] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      ['␓'] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()], gui = 'bold' }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.blue, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  'datetime',
  style = '%H:%M:%S %m-%d %a',
  cond = conditions.hide_in_width,
  color = { fg = colors.fg }
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
