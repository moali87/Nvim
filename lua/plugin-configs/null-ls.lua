local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.stylua
  },
})
