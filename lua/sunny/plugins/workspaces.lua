-- workspaces.nvim: VS Code-style multi-root workspaces (local dev copy)
return {
  dir = "~/github/workspaces.nvim",
  name = "workspaces.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = false, -- startup workspace picker hooks VimEnter
  -- Plugin defaults otherwise: sessions in stdpath("data")/workspaces/, startup
  -- picker on, cwd follows the workspace root, keymaps as listed in KEYBINDINGS.md.
  opts = {},
}
