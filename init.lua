require('package-manager')
require('lsp')
require('code_actions_utils')
require('fzf-config')
require('key-functions')

-- VIM Leader key
vim.g.mapleader = ","

-- python3
vim.g.python3_host_prog = "/Users/akhter.ali/.pyenv/shims/python"

-- UTF-8
vim.opt.encoding = "utf-8"

-- VIM RTP
vim.api.nvim_command([[
set rtp+=/usr/local/opt/fzf
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
vim.api.nvim_command("colorscheme monokai_pro")

-- VIM editor settings
vim.api.nvim_command([[
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
-- Map LazyGit
nmap("<leader>gg", ":LazyGit<CR>")

-- Map buffer movement
nmap("<leader>w", ":bprevious<CR>")
nmap("<leader>e", ":bnext<CR>")
nmap("<leader>q", ":bd<CR>")
nmap("<Leader>Q", ":bd!<CR>")

-- Map panel movement keys
nmap("<leader>v", "<C-W><C-J>")
nmap("<leader>f", "<C-W><C-K>")
nmap("<leader>r", "<C-W><C-H>")
nmap("<leader>t", "<C-W><C-L>")

-- Map fzf-lua
nmap("<C-o>", "<cmd>lua require('fzf-lua').files({ fd_opts = \"--hidden  --color=always --exclude '{API.*,.git/*,node_modules/*,docs/*}'\"})<CR>")
nmap("<C-p>", "<cmd>lua require('fzf-lua').grep_visual({ rg_opts = \"--hidden --column --line-number --no-heading --color=always --smart-case -g '!{API.*,.git/*,node_modules,package-lock.json,docs/*}'\"})<CR>")

-- MISC toggles
nmap("<C-i>", ":IndentBlanklineToggle<CR>")

-- Map notes
nmap("<F5>", "<cmd> e ~/notes/Upstart Standup.norg<CR>")
nmap("<F6>", "<cmd> GkeepToggle<CR>")

-- Map Terminal
tmap("<Leader><ESC>", "<C-\\><C-n>")
nmap("<F9>", "<cmd> vsplit | term<CR>")

-- Eslint mapping
nmap("<leader>f", "mF:%!eslint_d --stdin --fix-to-stdout<CR>")
