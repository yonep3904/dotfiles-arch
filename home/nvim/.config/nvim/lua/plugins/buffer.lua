return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        },
      })

      vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "次のバッファ" })
      vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "前のバッファ" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "バッファを閉じる" })
    end,
  },
}
