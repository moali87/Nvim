local packer = require('packer')
local use = packer.use
return packer.startup(function()
  -- Non lazy loaded plugins
  use({ 'wbthomason/packer.nvim' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'tanvirtin/monokai.nvim' })
  use({
    'projekt0n/github-nvim-theme',
    require = { "nvim-lua/plenary.nvim" },
    config = function()
      require("github-theme").setup({
        theme_style = "dark_default",
      })
    end
  })
  use({ 'folke/lsp-colors.nvim' })
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'kdheepak/lazygit.nvim' })
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
    event = 'VimEnter',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('plugin-configs.luasnip')
        end,
        requires = { 'saadparwaiz1/cmp_luasnip' },
      },
    },
    config = function()
      require('plugin-configs.cmp')
    end
  })

  use({
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('navigator').setup({
        lsp = {
          format_on_save = false
        }
      })
    end
  })

  use({
    'ray-x/go.nvim',
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
    },
    config = function ()
      require('go').setup()
    end
  })

  use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp',
    config = function()
      require('plugin-configs.cmp-lsp-config')
    end })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' })
  use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })

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
