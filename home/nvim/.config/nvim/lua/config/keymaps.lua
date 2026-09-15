local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "検索ハイライトを消す" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "終了" })

map("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ" })
map("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ" })
map("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ" })
map("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "選択行を下へ" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "選択行を上へ" })
map("v", "<", "<gv", { desc = "インデントを減らす" })
map("v", ">", ">gv", { desc = "インデントを増やす" })
map("x", "<leader>p", [["_dP]], { desc = "レジスタを保って貼り付け" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "前の診断" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "次の診断" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "行の診断を表示" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "診断一覧" })

local function set_indent_size(size)
  vim.bo.tabstop = size
  vim.bo.shiftwidth = size
  vim.bo.softtabstop = size
  vim.bo.expandtab = true
  vim.notify(("Indent size: %d spaces"):format(size))
end

map("n", "<leader>it", function()
  set_indent_size(vim.bo.shiftwidth == 2 and 4 or 2)
end, { desc = "インデント幅を2/4で切り替え" })
