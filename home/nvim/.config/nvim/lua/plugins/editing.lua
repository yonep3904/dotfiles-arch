return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      end
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash ジャンプ",
      },
      {
        "S",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "診断一覧",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "現在のファイルの診断一覧",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<CR>",
        desc = "シンボル一覧",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<CR>",
        desc = "Quickfix 一覧",
      },
    },
  },
}
