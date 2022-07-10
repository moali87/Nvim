require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.eslint_d,
    require("null-ls").builtins.diagnostics.golangci_lint,
    require("null-ls").builtins.completion.luasnip,
    require("null-ls").builtins.diagnostics.markdownlint,
    require("null-ls").builtins.diagnostics.pylint,
    require("null-ls").builtins.diagnostics.fish,
    require("null-ls").builtins.formatting.stylua,
    -- require("null-ls").builtins.completion.spell,
    -- require("null-ls").builtins.diagnostics.luacheck,
  },
})
