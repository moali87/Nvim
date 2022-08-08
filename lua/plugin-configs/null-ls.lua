local nls = require("null-ls")
nls.setup({
  debug = true,
  sources = {
    nls.builtins.hover.dictionary,
    nls.builtins.formatting.eslint_d,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.code_actions.eslint_d,
    nls.builtins.diagnostics.cfn_lint,
    nls.builtins.diagnostics.fish,
    nls.builtins.diagnostics.golangci_lint,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.goimports,
    nls.builtins.diagnostics.jsonlint,
    nls.builtins.diagnostics.pylint,
    nls.builtins.diagnostics.rubocop,
    nls.builtins.formatting.rubocop,
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.diagnostics.vale,
    nls.builtins.diagnostics.yamllint,
    nls.builtins.formatting.rustfmt,
    nls.builtins.formatting.terraform_fmt
    -- nls.builtins.formatting.stylua,
    -- nls.builtins.diagnostics.selene
  }
})
