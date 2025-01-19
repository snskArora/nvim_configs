return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      hijack_cursor = true,
      view = {
        width = 35,
        relativenumber = true,
        signcolumn = "auto",
      },
      renderer = {
        full_name = true, --show full name in floating window if doesnt fit in pane
        special_files = { "Cargo.toml", "requirements.txt", "setup.cfg", "Makefile", "README.md", "readme.md" },
        hidden_display = "simple",
        highlight_modified = "all",
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "before",
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
            git = {
              unstaged = "~",
              staged = "✓",
              unmerged = "",
              renamed = "★",
              untracked = "✗",
              deleted = "-",
              ignored = "◌",
            },

          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        use_system_clipboard = true,
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      git = {
        ignore = false,
      },
      diagnostics = {
        enable = true,
        severity = {
          min = vim.diagnostic.severity.INFO,
          max = vim.diagnostic.severity.ERROR,
        },
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end
}
