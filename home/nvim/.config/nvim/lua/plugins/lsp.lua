return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "basedpyright",
            "clangd",
            "lua_ls",
            "rust_analyzer",
            "tsgo",
          },
          automatic_enable = false,
        },
      },
    },
    config = function()
      require("lsp").setup()
    end,
  },
}
