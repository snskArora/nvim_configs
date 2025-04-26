local picker = require "telescope.pickers"
local finder = require "telescope.finders"
local entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local M = {}

local supercharger = function(opts)
  opts = opts or {}
  opts.cwd  = opts.cwd or vim.uv.cwd()

  local searcher = finder.new_async_job {
    command_generator = function (prompt)
      if not prompt or prompt == "" or prompt == " " then
        return nil
      end

      local tranches = vim.split(prompt, " |:| ")
      local args = { "rg" }

      if tranches[1] then
        table.insert(args, "-e")
        table.insert(args, tranches[1])
      end

      if tranches[2] then
        local globs = vim.split(tranches[2], ", ")
        for _, glob in ipairs(globs) do
          table.insert(args, "-g")
          table.insert(args, glob)
        end
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  picker.new(opts, {
    debounce = 100,
    prompt_title = "Supercharged Multi Grep",
    finder = searcher,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

M.setup = function ()
  vim.keymap.set("n", "<leader>fcg", supercharger)
end

M.better_grep = supercharger

return M
