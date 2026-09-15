return {
  {
    "tpope/vim-sleuth",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
      },
    },
  },
}
