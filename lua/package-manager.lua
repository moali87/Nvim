require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lsp";

    "neovim/nvim-lspconfig";          -- Mind the semi-colons

    {"lervag/vimtex", opt=true};      -- Use braces when passing options
    "nvim-lualine/lualine.nvim";
    "kyazdani42/nvim-web-devicons";
    "nvim-lua/plenary.nvim";
    "lewis6991/gitsigns.nvim";
    "folke/trouble.nvim";
    "907th/vim-auto-save";
    "windwp/nvim-autopairs";
    "preservim/nerdcommenter";
    "hashivim/vim-terraform";
    "lukas-reineke/indent-blankline.nvim";
    "ibhagwan/fzf-lua";
    "kdheepak/lazygit.nvim";
    "folke/lsp-colors.nvim";
    "ntpeters/vim-better-whitespace";
    "akinsho/bufferline.nvim";
    "L3MON4D3/LuaSnip";
    "saadparwaiz1/cmp_luasnip";
    "mfussenegger/nvim-lint";
    "tanvirtin/monokai.nvim";
    "nvim-treesitter/nvim-treesitter";
    "lewis6991/impatient.nvim";
}

require('bufferline').setup{}
require("luasnip.loaders.from_vscode").lazy_load()
require('nvim-autopairs').setup{}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
