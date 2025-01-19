return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function ()
    require("gitsigns").setup({
    current_line_blame_opts = {
      delay = 100,
    },
  })
  end,
}
