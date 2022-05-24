local cmp = require('plugin-configs.cmp')
local luasnip = require('luasnip')

cmp.setup.snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    luasnip.lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end
}
return cmp
