return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
      {
        "<leader>ct",
        function()
          require("copilot.command").toggle()
          vim.notify("Copilot toggled for this buffer")
        end,
        desc = "Toggle Copilot for this buffer",
      },
    },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
      },
    },
  },
}
