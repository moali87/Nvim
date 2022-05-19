require('package-manager')
require('lsp')
require('code_actions_utils')
require('fzf-config')
require('key-functions')

-- VIM Leader key
vim.g.mapleader = ","

-- python3
vim.g.python3_host_prog = "~/.pyenv/shims/python"

-- disable perl provider
vim.g.loaded_perl_provider = 0

-- nodejs
vim.g.node_host_prog = '~/.local/share/nvm/v16.13.0/bin/neovim-node-host'

-- UTF-8
vim.opt.encoding = "utf-8"

-- VIM RTP
vim.api.nvim_command([[
set rtp+=/usr/local/opt/fzf
set rtp+=~/.local/share/nvm/v16.13.0
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
nmap("<Leader>gg", ":LazyGit<CR>")

-- Map buffer movement
nmap("<Leader>w", ":bprevious<CR>")
nmap("<Leader>e", ":bnext<CR>")
nmap("<Leader>q", ":bd<CR>")
nmap("<Leader>Q", ":bd!<CR>")
nmap("<F2>", ":vert sb")

-- Map panel movement keys
nmap("<Leader>v", "<C-W><C-J>")
nmap("<Leader>f", "<C-W><C-K>")
nmap("<Leader>r", "<C-W><C-H>")
nmap("<Leader>t", "<C-W><C-L>")

-- Map fzf-lua
nmap("<C-o>", "<cmd>lua require('fzf-lua').files({ fd_opts = \"--hidden  --color=always --exclude '{API.*,.git/*,node_modules/*,docs/*}'\"})<CR>")
nmap("<C-p>", "<cmd>lua require('fzf-lua').grep_visual({ rg_opts = \"--hidden --column --line-number --no-heading --color=always --smart-case -g '!{API.*,.git/*,node_modules,package-lock.json,docs/*}'\"})<CR>")

-- Map notes
nmap("<F5>", "<cmd> e ~/notes/Upstart Standup.norg<CR>")
nmap("<F6>", "<cmd> GkeepToggle<CR>")

-- Map Terminal
tmap("<Leader><ESC>", "<C-\\><C-n>")
nmap("<F9>", "<cmd> vsplit | term<CR>")

-- Eslint mapping
--nmap("<Leader>f", "mF:%!eslint_d --stdin --fix-to-stdout<CR>")
