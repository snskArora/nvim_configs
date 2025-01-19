return {
  "EdenEast/nightfox.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.cmd("colorscheme  carbonfox")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
