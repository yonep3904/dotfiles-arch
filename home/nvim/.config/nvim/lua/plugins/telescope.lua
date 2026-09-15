return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<Esc>"] = require("telescope.actions").close },
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイル検索" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "文字列検索" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "バッファ検索" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "ヘルプ検索" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "最近使ったファイル" })
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "現在のファイル内を検索" })
    end,
  },
}
