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
    "windwp/nvim-autopairs";
    "preservim/nerdcommenter";
    "lukas-reineke/indent-blankline.nvim";
    "ibhagwan/fzf-lua";
    "kdheepak/lazygit.nvim";
    "folke/lsp-colors.nvim";
    "ntpeters/vim-better-whitespace";
    {"akinsho/bufferline.nvim", branch="main"};
    "L3MON4D3/LuaSnip";
    "saadparwaiz1/cmp_luasnip";
    "mfussenegger/nvim-lint";
    "tanvirtin/monokai.nvim";
    "nvim-treesitter/nvim-treesitter";
    "lewis6991/impatient.nvim";
    "nvim-neorg/neorg";
    {'stevearc/gkeep.nvim', run = vim.fn['remote#host#UpdateRemotePlugins']};
}

require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    numbers =  "both",
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
    end,
    -- offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
    -- color_icons = true | false, -- whether or not to add the filetype icon highlights
    color_icons = true, -- whether or not to add the filetype icon highlights
    -- show_buffer_icons = true | false, -- disable filetype icons for buffers
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    -- show_buffer_default_icon = true | false, -- whether or not an unrecognised filetype should show a default icon
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
    separator_style = "slant",
    -- enforce_regular_tabs = false | true,
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    sort_by = 'id'
  }
}

require("luasnip.loaders.from_vscode").lazy_load()

require('nvim-autopairs').setup{}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "norg",
    "typescript",
    "lua",
    "go",
    "ruby",
    "fish",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsdoc",
    "yaml",
    "bash"
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('neorg').setup {
    load = {
        ["core.defaults"] = {}
    }
}
