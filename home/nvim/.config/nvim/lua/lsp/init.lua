local M = {}

local function capabilities()
  local result = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  if ok then
    result = cmp_nvim_lsp.default_capabilities(result)
  end

  return result
end

local function configure_diagnostics()
  vim.diagnostic.config({
    severity_sort = true,
    virtual_text = { spacing = 2, source = "if_many" },
    float = { border = "rounded", source = true },
    signs = true,
    underline = true,
  })
end

local function configure_keymaps()
  local group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "LSP 接続時にバッファローカルなキーマップを設定する",
    callback = function(event)
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
      end

      map("gd", vim.lsp.buf.definition, "定義へ移動")
      map("gD", vim.lsp.buf.declaration, "宣言へ移動")
      map("gr", vim.lsp.buf.references, "参照を表示")
      map("gi", vim.lsp.buf.implementation, "実装へ移動")
      map("K", vim.lsp.buf.hover, "ドキュメントを表示")
      map("<leader>rn", vim.lsp.buf.rename, "シンボル名を変更")
      map("<leader>ca", vim.lsp.buf.code_action, "コードアクション")
    end,
  })
end

local function configure_servers()
  local servers = {
    lua_ls = {},
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    },
    tsgo = {},
    clangd = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
      },
    },
  }

  local client_capabilities = capabilities()

  for name, config in pairs(servers) do
    config.capabilities = client_capabilities
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  end
end

function M.setup()
  configure_diagnostics()
  configure_keymaps()
  configure_servers()
end

return M
