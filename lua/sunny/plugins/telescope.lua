return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "BurntSushi/ripgrep",
    "Sharkdp/fd",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod
    local addon = require("sunny.telescope_addons")

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      -- Commenting these keymaps in favour of tmux navs
      -- defaults = {
      --   path_display = { "smart" },
      --   mappings = {
      --     i = {
      --       ["<C-k>"] = actions.move_selection_previous, -- move to prev result
      --       ["<C-j>"] = actions.move_selection_next, -- move to next result
      --       ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
      --       ["<C-t>"] = trouble_telescope.open,
      --     },
      --   },
      -- },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set('n', '<leader>fs', function() addon.better_grep() end, { desc = "Telescope find in cwd with mods" })
    keymap.set("n", "<leader>feus", "<cmd>Telescope live_grep<cr>", { desc = "Find in cwd" })
    keymap.set("n", "<leader>grep", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>LB", "<cmd>Telescope buffers<cr>", {desc = "Show open buffers"})
    keymap.set("n", "<leader>rg", "<cmd>Telescope registers<cr>", { desc = "Show values in the register" })
    keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_document_symbols<cr>", {desc = "Show refs of current word in buffer"})
    keymap.set("n", "<leader>arf", "<cmd>Telescope lsp_workspace_symbols<cr>", {desc = "Show refs of current word in workspace"})
    keymap.set("n", "<leader>mrk", "<cmd>Telescope marks<cr>", {desc = "Show all marks"})
    keymap.set("n", "<leader>gwt", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", {desc = "Show git worktrees"})
    keymap.set("n", "<leader>gwa", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", {desc = "Create a git worktree"})
  end,
}
