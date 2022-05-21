local packer = require('packer')
local use = packer.use
return packer.startup(function ()
  use({'wbthomason/packer.nvim'})

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require('plugin-configs.treesitter')
    end
  })

  use({'tanvirtin/monokai.nvim'})
  use({'folke/lsp-colors.nvim'})
  use({'nvim-lua/plenary.nvim'})
  use({'kdheepak/lazygit.nvim'})

  use({
    'lewis6991/impatient.nvim',
    config = function ()
      require('impatient').enable_profile()
    end
  })

  use({
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'mtoohey31/cmp-fish',
    'saadparwaiz1/cmp_luasnip',
    requires = {{'neovim/nvim-lspconfig'}, opt = true},
    config = function ()
      require('plugin-configs.nvim-lspconfig')
    end
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup()
    end
  })

  use({
    'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require('plugin-configs.fzf-lua.fzf-lua')
    end
  })

  use({
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = {{'kyazdani42/nvim-web-devicons'}, opt = true}, config = function ()
      require('bufferline').setup({
        require('plugin-configs.bufferline')
      })
    end
  })

  use({
    'mfussenegger/nvim-lint',
    requires = {{'nvim/nvim-lspconfig'}, opt = true},
    config = function ()
      require('plugin-configs.nvim-lint')
    end
  })

  use({
      "nvim-neorg/neorg",
      config = function()
        require('neorg').setup {
          require('plugin-configs.neorg')
        }
      end,
      requires = "nvim-lua/plenary.nvim"
  })

  use({
    'stevearc/gkeep.nvim',
    run = ':UpdateRemotePlugins',
    config = function ()
      vim.g.gkeep_sync_dir = '~/notes'
    end
  })

  use({
    'numToStr/Comment.nvim',
    config = function ()
      require('Comment').setup()
    end
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function ()
      require('indent_blankline').setup{
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = true,
      }
    end
  })

  use({
    'lewis6991/gitsigns.nvim',
    tag = 'release', -- To use the latest release
    config = function ()
      require('gitsigns').setup()
    end
  })

  -- Lazy loaded
  use({
    'L3MON4D3/LuaSnip',
    config = function ()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  })

  use({
    'windwp/nvim-autopairs',
    requires = {{'hrsh7th/nvim-cmp'}, opt = true},
    config = function ()
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
      cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
    end
  })
end)
