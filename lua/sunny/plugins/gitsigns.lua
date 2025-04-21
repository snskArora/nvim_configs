return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function ()
    local gs = require("gitsigns")
    gs.setup({
      signs_staged_enable = true,
      signcolumn = false, -- enable signcolumn from settings.lua, vim.opt
      numhl      = true,
      linehl     = false,
      word_diff  = false,
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    })
    vim.keymap.set("n", "<leader>ghn", function() gs.nav_hunk('next', {target='all', preview=true}) end, {desc = "navigate to next hunk"})
    vim.keymap.set("n", "<leader>ghp", function() gs.nav_hunk('prev', {target='all', preview=true}) end, {desc = "navigate to previous hunk"})
    vim.keymap.set("n", "<leader>ghs", function() gs.stage_hunk() end, {desc = "stage this hunk"})
    vim.keymap.set("n", "<leader>ghu", function() gs.reset_hunk() end, {desc = "undo unstaged changes of this hunk"})
    vim.keymap.set("n", "<leader>ghi", function() gs.preview_hunk_inline() end, {desc = "show inline hunk"})
  end,
}
