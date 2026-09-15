local group = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "ヤンクした範囲を短く強調する",
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "ヘルプなどでは q で閉じる",
  pattern = { "help", "qf", "checkhealth", "man", "notify" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = event.buf,
      silent = true,
      desc = "ウィンドウを閉じる",
    })
  end,
})
