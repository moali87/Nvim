local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local servers = {
  'clangd',
  'rust_analyzer',
  'pyright',
  'tsserver',
  'gopls',
  'terraformls',
  'tflint'
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- LSP notify
local client_notifs = {}
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" } -- spinners

local function update_spinner(notif_data) -- update spinner helper function to defer
  if notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = vim.notify(nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn(function()
      update_spinner(notif_data)
    end, 100)
  end
end

vim.api.nvim_create_augroup("lsp_notify", { clear = true }) -- create augroup
vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressUpdate", -- LSP Progress Update autocommand
  group = "lsp_notify",
  desc = "LSP progress notification",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf() -- get buffer number
    for _, client in pairs(vim.lsp.buf_get_clients()) do -- loop over each client to check notifications
      if not client_notifs[bufnr] then -- create buffer specific notification table if not exists
        client_notifs[bufnr] = {}
      end
      if not client_notifs[bufnr][client.id] then -- create buffers client  specific  notification table if not exists
        client_notifs[bufnr][client.id] = {}
      end
      local notif_data = client_notifs[bufnr][client.id] -- set notif_data variable
      local progress = nil
      for _, progress_msg in pairs(client.messages.progress) do
        progress = true -- expose if a progress exists
        if not progress_msg.done then
          progress = progress_msg -- get clients first not done progress messages
          break
        end
      end
      if type(progress) == "table" and progress.percentage and progress.percentage ~= 0 then -- if there is a progress message
        local notify_opts = {} -- define notification options
        local new_msg = notif_data.notification == nil -- if it's a new message set different options
        if new_msg then -- for new messages set a title, initialize icone and disable timeout
          notify_opts = {
            title = client.name .. (#progress.title > 0 and ": " .. progress.title or ""),
            icon = spinner_frames[1],
            timeout = false,
          }
        else -- for existing messages just update the existing notification
          notify_opts = { replace = notif_data.notification }
        end
        notif_data.notification = vim.notify( -- notify with percentage and message
          (progress.percentage and progress.percentage .. "%\t" or "") .. (progress.message or ""),
          "info",
          notify_opts
        )
        if new_msg then -- if it's a new message, start the update spinner background job
          update_spinner(notif_data)
        end
      elseif progress and not vim.tbl_isempty(notif_data) then -- if there is finished progress and a notification, complete it
        notif_data.notification = vim.notify(
          "Complete",
          "info",
          { icon = "", replace = notif_data.notification, timeout = 3000 }
        )
        notif_data = {} -- clear notification data
      end
    end
  end,
})
