local function javascript_formatter(bufnr)
  local biome_root = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
  return biome_root and { "biome" } or { "prettier" }
end

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "biome",
        "clang-format",
        "prettier",
        "ruff",
      },
      run_on_start = true,
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "コードを整形",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = javascript_formatter,
        javascriptreact = javascript_formatter,
        typescript = javascript_formatter,
        typescriptreact = javascript_formatter,
        json = javascript_formatter,
        jsonc = javascript_formatter,
        css = javascript_formatter,
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    },
  },
}
