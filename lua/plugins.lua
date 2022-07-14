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
  use({ 'glepnir/dashboard-nvim' })
  use({ 'lewis6991/impatient.nvim', config = function() require('impatient').enable_profile() end })
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
    -- event = {'InsertEnter *', 'CmdlineEnter'},
    event = 'BufWinEnter',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('plugin-configs.luasnip')
        end,
        requires = {
          'saadparwaiz1/cmp_luasnip',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-cmdline',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-signature-help',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-path',
          {
            'ibhagwan/fzf-lua',
            config = function ()
              require('plugin-configs.fzf-lua')
            end
          }
        },
      },
    },
    config = function()
      require('plugin-configs.cmp')
    end
  })

  -- Trouble
  use {
    "folke/trouble.nvim",
    requires = 'hrsh7th/nvim-cmp',
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- notify
  use({
    'rcarriga/nvim-notify',
    requires = 'hrsh7th/nvim-cmp',
    config = function()
      vim.notify = require('notify')
      require('plugin-configs.notify')
    end
  })

  -- nvim-go
  use({
    'crispgm/nvim-go',
    requires = 'rcarriga/nvim-notify',
    config = function()
      require('go').setup({})
    end
  })

  -- bufdelete
  use({
    'famiu/bufdelete.nvim',
    event = 'BufWinEnter'
  })

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
  --[[ use({
    'ibhagwan/fzf-lua',
    event = "VimEnter",
    config = function()
      require('plugin-configs.fzf-lua')
    end
  }) ]]

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
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require('plugin-configs.null-ls')
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- neorg
  use({
    'nvim-neorg/neorg',
    requires = 'nvim-lua/plenary.nvim',
    ft = 'norg',
    after = 'nvim-treesitter',
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
    requires = { { 'hrsh7th/nvim-cmp' } },
    config = function()
      require('nvim-autopairs').setup()
    end
  })
end)
