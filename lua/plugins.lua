local packer = require('packer')
local use = packer.use
return packer.startup(function()
  -- Non lazy loaded plugins
  use({ 'wbthomason/packer.nvim' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'tanvirtin/monokai.nvim' })
  use({ 'folke/lsp-colors.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'kdheepak/lazygit.nvim' })
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    -- event = 'BufEnter',
    config = function()
      require('nvim-treesitter.configs').setup(require('plugin-configs.treesitter'))
    end
  })

  -- Lazy loaded plugins
  -- cmp and cmp attachments
  use({
    'hrsh7th/nvim-cmp',
    after = 'nvim-lspconfig',
    event = 'VimEnter',
    config = function()
      require('plugin-configs.cmp')
    end
  })

  use({'hrsh7th/cmp-buffer', after = 'nvim-cmp'})
  use({'hrsh7th/cmp-cmdline', after = 'nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp',
  config = function ()
    require('plugin-configs.cmp-lsp-config')
  end})
  use({'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'})
  use({'hrsh7th/cmp-path', after = 'nvim-cmp'})
  use({'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'})
  use({'L3MON4D3/LuaSnip', after = 'nvim-cmp', config = function ()
    require('plugin-configs.luasnip-config')
    require('luasnip.loaders.from_vscode').lazy_load()
  end})


  -- lualine
  use({
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('lualine').setup({
        options = { theme = 'powerline' }
      })
    end
  })

  -- fzf-lua
  use({
    'ibhagwan/fzf-lua',
    event = "VimEnter",
    config = function()
      require('plugin-configs.fzf-lua')
    end
  })

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    event = "BufWinEnter",
    tag = 'v2.*',
    config = function()
      require('bufferline').setup(
        require('plugin-configs.bufferline-config')
      )
    end
  })

  -- lint
  use({
    'mfussenegger/nvim-lint',
    requires = { { 'neovim/nvim-lspconfig' }},
    event = "BufRead",
    config = function()
      require('lint').linters_by_ft = require('plugin-configs.nvim-lint')
    end
  })

  -- neorg
  use({
    'nvim-neorg/neorg',
    requires = 'nvim-lua/plenary.nvim',
    event = 'VimEnter',
    config = function()
      require('neorg').setup(require('plugin-configs.neorg-config'))
    end
  })

  -- comment
  use({
    'numToStr/Comment.nvim',
    event = 'BufWinEnter',
    config = function()
      require('Comment').setup()
    end
  })

  -- blankline
  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufWinEnter',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      }
    end
  })

  -- gitsigns
  use({
    'lewis6991/gitsigns.nvim',
    event = 'BufWinEnter',
    tag = 'release', -- To use the latest release
    config = function()
      require('gitsigns').setup()
    end
  })

  -- autopairs
  use({
    'windwp/nvim-autopairs',
    event = 'BufWinEnter',
    requires = { { 'hrsh7th/nvim-cmp' }},
    config = function()
      require('nvim-autopairs').setup()
    end
  })
end)
