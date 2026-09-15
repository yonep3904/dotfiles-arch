return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("]h", gs.next_hunk, "次の変更箇所")
        map("[h", gs.prev_hunk, "前の変更箇所")
        map("<leader>hp", gs.preview_hunk, "変更箇所をプレビュー")
        map("<leader>hb", gs.blame_line, "この行の Git 履歴")
      end,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>d", group = "diagnostic" },
        { "<leader>f", group = "find" },
        { "<leader>h", group = "git hunk" },
        { "<leader>x", group = "trouble" },
      },
    },
  },
}
