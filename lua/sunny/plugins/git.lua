return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function ()
    require('neogit').setup{
      kind = "auto",
      commit_editor = {
        kind = "split_below",
        show_staged_diff = true,
        staged_diff_split_kind = "split_above",
        spell_check = true,
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "floating",
        verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "tab",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "tab",
      },
      description_editor = {
        kind = "auto",
      },
      tag_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "floating",
      },
      popup = {
        kind = "split",
      },
      stash = {
        kind = "tab",
      },
      refs_view = {
        kind = "tab",
      },
    } -- auto => vsplit if window would have 80 cols, otherwise split
    vim.keymap.set("n", "<leader>gt", "<cmd>Neogit<cr>", {desc = "Open neogit window"})
  end
}

