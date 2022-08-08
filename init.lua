require('plugins')
require('code_actions_utils')
require('key-functions')

-- VIM Leader key
vim.g.mapleader = ","

-- python3
vim.g.python3_host_prog = "expand('~/.pyenv/shims/python')"

-- disable perl provider
vim.g.loaded_perl_provider = 0

-- nodejs
vim.g.node_host_prog = '~/.local/share/nvm/v16.13.0/bin/neovim-node-host'

-- UTF-8
vim.opt.encoding = "utf-8"

-- VIM RTP
vim.api.nvim_command([[
set rtp+=~/.local/share/nvm/v16.13.0
set rtp+=~/opt/homebrew/bin/
]])

-- VIM folding
vim.api.nvim_command([[
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
]])

-- VIM Colorscheme
vim.api.nvim_command("set termguicolors")
vim.api.nvim_command("colorscheme minimal")

-- VIM editor settings
vim.opt.guicursor = ""
vim.api.nvim_command([[
set scrolloff=10
set relativenumber
set number
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set wildmenu
set wildmode=full,list
set nocompatible
set shell=/usr/local/bin/fish
syntax on
set completeopt=menu,menuone,noselect
set fillchars+=vert:\|
hi vertsplit guifg=fg guibg=bg
hi Visual term=reverse cterm=reverse guibg=Grey
set laststatus=3
]])

-- Disable arrow keys
imap("<up>", "<nop>")
imap("<down>", "<nop>")
imap("<left>", "<nop>")
imap("<right>", "<nop>")

-- Map keys
-- Map LazyGit
nmap("<Leader>gg", ":LazyGit<CR>")

-- Map buffer movement
nmap("<Leader>w", ":bprevious<CR>")
nmap("<Leader>e", ":bnext<CR>")
nmap("<Leader>q", ":bd<CR>")
nmap("<Leader>Q", ":bd!<CR>")
nmap("<F2>", ":vert sb")

-- Map panel movement keys
-- Down
nmap("<Leader>v", "<C-W><C-J>")
-- Up
nmap("<Leader>r", "<C-W><C-K>")
-- Left
nmap("<Leader>f", "<C-W><C-H>")
-- Right
nmap("<Leader>j", "<C-W><C-L>")

-- Map fzf-lua
nmap("<C-o>", "<cmd>lua require('fzf-lua').files({ fd_opts = \"--hidden  --color=always --exclude '{API.*,.git/*,node_modules/*,docs/*}'\"})<CR>")
nmap("<C-p>", "<cmd>lua require('fzf-lua').grep_visual()<CR>")
-- nmap("<C-p>", "<cmd>lua require('fzf-lua').live_grep({ rg_opts = '--hidden --column --line-number --no-heading --color=always --smart-case '})<CR>")

-- Map Terminal
tmap("<Leader><ESC>", "<C-\\><C-n>")
tmap("<F9>", "<cmd> vsplit | term<CR>")

-- MISC toggles
nmap("<F4>", "<cmd> IndentBlanklineToggle<CR>")

-- Notes mapping
nmap("<F5>", "<cmd> e ~/notes/Upstart Standup.norg<CR>")
vim.keymap.set('n', '<F5>', function ()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative='editor', border='double', width=100, height=50, row=1, col=35
  })
  vim.cmd('e ~/notes/Upstart Standup.norg')
  vim.keymap.set('n', '<ESC>', '<cmd>w | bd<CR>')
end)

-- Eslint mapping
-- nmap("<leader>f", "mF:%!eslint_d --stdin --fix-to-stdout<CR>")
