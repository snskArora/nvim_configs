-- <leader>frf: pick one top-level workspace folder (workspaces.nvim), then
-- search LSP workspace symbols live — one workspace/symbol request per
-- keystroke to every running server that supports it — keeping only symbols
-- from files inside that folder. Uses the per-filetype filter in
-- sunny/lsp_symbols.lua (applied per result file).
local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "folder symbols" })
end

-- "<parent>/<folder>/", e.g. /home/me/work/app/ -> work/app/
local function label(folder)
  local trimmed = folder:gsub("/$", "")
  local name = vim.fn.fnamemodify(trimmed, ":t")
  local parent = vim.fn.fnamemodify(trimmed, ":h:t")
  return (parent ~= "" and parent .. "/" or "") .. name .. "/"
end

local function symbol_clients()
  return vim.tbl_filter(function(c)
    return c.server_capabilities and c.server_capabilities.workspaceSymbolProvider
  end, vim.lsp.get_clients())
end

-- Hidden kinds per result file's filetype. Filetype detection is cached per
-- file name (vim.filetype.match is the expensive part), the kind set per filetype.
local function make_filter()
  local lsp_symbols = require("sunny.lsp_symbols")
  local ft_of, hidden = {}, {}
  return function(item)
    local ft = ft_of[item.filename]
    if ft == nil then
      ft = vim.filetype.match({ filename = item.filename }) or ""
      ft_of[item.filename] = ft
    end
    if hidden[ft] == nil then
      local set = {}
      for _, k in ipairs(lsp_symbols.ignore_for(ft)) do
        set[k:lower()] = true
      end
      hidden[ft] = set
    end
    return not hidden[ft][(item.kind or ""):lower()]
  end
end

-- Async requester for Telescope's dynamic finder: query all clients, cancel
-- the previous round on each keystroke, keep (deduplicated) items in `folder`.
local function requester(folder, clients)
  local channel = require("plenary.async.control").channel
  local keep = make_filter()
  local inflight = {} -- client -> request id

  local function cancel()
    for client, id in pairs(inflight) do
      pcall(client.cancel_request, client, id)
    end
    inflight = {}
  end

  return function(prompt)
    cancel()
    local tx, rx = channel.oneshot()
    local pending, items, seen = #clients, {}, {}
    for _, client in ipairs(clients) do
      local ok, id = client:request("workspace/symbol", { query = prompt }, function(err, result)
        inflight[client] = nil
        if not err and result then
          for _, item in ipairs(vim.lsp.util.symbols_to_items(result, 0, client.offset_encoding)) do
            -- several servers (or instances of one) can index the same folder
            local key = table.concat({ item.filename or "", item.lnum or 0, item.col or 0, item.text or "" }, ":")
            if item.filename and not seen[key] and vim.startswith(item.filename, folder) and keep(item) then
              seen[key] = true
              table.insert(items, item)
            end
          end
        end
        pending = pending - 1
        if pending == 0 then
          tx(items)
        end
      end)
      if ok then
        inflight[client] = id
      else
        pending = pending - 1
      end
    end
    if pending == 0 then
      tx(items)
    end
    return rx()
  end
end

local function search(folder)
  local clients = symbol_clients()
  if #clients == 0 then
    notify("No running LSP server supports workspace symbols.", vim.log.levels.WARN)
    return
  end
  local conf = require("telescope.config").values
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Symbols in " .. label(folder),
      results_title = "type to search · <CR> open",
      finder = require("telescope.finders").new_dynamic({
        fn = requester(folder, clients),
        entry_maker = require("telescope.make_entry").gen_from_lsp_symbols({}),
      }),
      previewer = conf.qflist_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

function M.open()
  local ok, ws = pcall(require, "workspaces")
  local folders = ok and ws.get_folders() or {}
  if #folders == 0 then
    notify("Workspace has no folders.", vim.log.levels.WARN)
    return
  end
  if #folders == 1 then
    return search(folders[1])
  end
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Symbols: pick a folder",
      results_title = "<CR> select",
      finder = require("telescope.finders").new_table({
        results = folders,
        entry_maker = function(f)
          local text = label(f)
          return { value = f, display = text, ordinal = text }
        end,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.schedule(function()
              search(selection.value)
            end)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
