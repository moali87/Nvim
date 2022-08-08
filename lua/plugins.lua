local packer = require('packer')
local use = packer.use
return packer.startup(function()
  -- Non lazy loaded plugins
  use({ 'wbthomason/packer.nvim' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'Yazeed1s/minimal.nvim' })
  use({ 'folke/lsp-colors.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'kdheepak/lazygit.nvim' })
  use({ 'glepnir/dashboard-nvim' })
  use({ 'lewis6991/impatient.nvim', config = function() require('impatient').enable_profile() end })
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  -- Lazy loaded plugins

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup(require('plugin-configs.treesitter'))
    end
  })
  -- cmp and cmp attachments
  use({
    'hrsh7th/nvim-cmp',
    after = 'nvim-lspconfig',
    -- event = {'InsertEnter *', 'CmdlineEnter'}, -- Can't do this cause it's slow
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
        },
      },
    },
    config = function()
      require('plugin-configs.cmp')
    end
  })

  use({ 'anuvyklack/fold-preview.nvim',
   requires = 'anuvyklack/keymap-amend.nvim',
   -- event = 'VimEnter',
   keys = {'h', 'l'},
   config = function()
      require('fold-preview').setup()
   end
  })

  -- Trouble
  -- use {
  --   "folke/trouble.nvim",
  --   -- event = {'InsertLeavePre'},
  --   config = function()
  --     require("trouble").setup {
  --       icons = false
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

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
  use({
    'ibhagwan/fzf-lua',
    -- keys = {'<C-o>', '<C-p>'},
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

  -- lspinstaller
  use({
    'williamboman/mason.nvim',
    config = function ()
      require("mason").setup({
        automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
        ui = {
          icons = {
              server_installed = "✓",
              server_pending = "➜",
              server_uninstalled = "✗"
          }
        }
    })
    end
  })

  -- lint
  -- null-ls
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function ()
      require('plugin-configs.null-ls')
    end
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
