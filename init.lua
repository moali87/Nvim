require('package-manager')
require('impatient')
require('lsp')
require('code_actions_utils')
require('fzf-config')
require('key-functions')

-- VIM Leader key
vim.g.mapleader = ","

-- UTF-8
vim.opt.encoding="utf-8"

-- VIM RTP
vim.cmd([[
set rtp+=/usr/local/opt/fzf
]])

-- VIM folding
vim.cmd([[
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
]])

-- VIM Colorscheme
vim.cmd([[
colorscheme monokai_pro
set termguicolors
]])

-- VIM editor settings
vim.cmd([[
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set wildmenu
set wildmode=full,list
set nocompatible
set shell=/bin/bash
syntax on
set completeopt=menu,menuone,noselect
au BufWritePost <buffer> lua require('lint').try_lint()
set fillchars+=vert:\|
hi vertsplit guifg=fg guibg=bg
hi Visual term=reverse cterm=reverse guibg=Grey
]])

-- Disable arrow keys

imap("<up>", "<nop>")
imap("<down>", "<nop>")
imap("<left>", "<nop>")
imap("<right>", "<nop>")

-- Map keys
nmap("<leader>gg", ":LazyGit<CR>")
nmap("<F3>", ":bprevious<CR>")
nmap("<F4>", ":bnext<CR>")
nmap("<F5>", ":bd<CR>")
nmap("<leader>f", "mF:%!eslint_d --stdin --fix-to-stdout<CR>")

-- Map panel movement keys
nmap("<F7>", "<C-W><C-J>")
nmap("<F8>", "<C-W><C-K>")
nmap("<F9>", "<C-W><C-H>")
nmap("<F10>", "<C-W><C-L>")

-- Map fzf-lua
nmap("<c-o>", "<cmd>lua require('fzf-lua').files({ fd_opts = \"--hidden  --color=always --exclude '{.git/*,node_modules/*}'\"})<CR>")

nmap("<c-p>", "<cmd>lua require('fzf-lua').grep_visual({ rg_opts = \"--hidden --column --line-number --no-heading --color=always --smart-case -g '!{API.*,.git/*,node_modules,package-lock.json}'\"})<CR>")

nmap("<F2>", "<cmd> lua require('fzf-lua').buffers()<CR>")
