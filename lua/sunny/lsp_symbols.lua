-- Per-filetype LSP symbol kinds to hide in symbol pickers
-- (<leader>rf, <leader>arf, workspaces.nvim <leader>frf).
-- Kinds are lowercase LSP SymbolKind names. An empty list hides nothing.
local M = {}

-- literals and keys: values, not declarations
local literals = { "number", "string", "boolean", "null", "key" }

-- lua_ls reports every table field / array item / literal as a symbol
local lua_noise = { "field", "array", "object", "number", "string", "boolean", "key", "null", "enummember" }

-- terraform-ls reports attributes by value type; keep blocks (Class)
local hcl_attrs = { "string", "number", "boolean", "null", "key", "constant", "struct", "array", "object" }

M.by_filetype = {
  lua = lua_noise,
  -- data/config files: the keys ARE the structure, show everything
  json = {}, jsonc = {}, yaml = {}, toml = {}, xml = {},
  -- shells / build files: few symbols, all meaningful
  sh = {}, bash = {}, zsh = {}, dockerfile = {}, make = {}, cmake = {}, ps1 = {},
  markdown = {},
  -- languages where fields / properties / constants are real declarations
  c = literals, cpp = literals, objc = literals, objcpp = literals, cuda = literals,
  java = literals, kotlin = literals, cs = literals, scala = literals,
  go = literals, rust = literals, zig = literals, swift = literals,
  python = literals, ruby = literals, php = literals,
  javascript = literals, javascriptreact = literals,
  typescript = literals, typescriptreact = literals,
  ["typescript.tsx"] = literals,
  terraform = hcl_attrs, ["terraform-vars"] = hcl_attrs, hcl = hcl_attrs,
}

-- unknown filetypes: the lua noise list, but keep fields
M.fallback = { "array", "object", "number", "string", "boolean", "key", "null", "enummember" }

function M.ignore_for(ft)
  local list = M.by_filetype[ft or ""]
  if list == nil then
    list = M.fallback
  end
  return list
end

-- Telescope opts for the current buffer's filetype.
function M.opts(bufnr)
  local list = M.ignore_for(vim.bo[bufnr or 0].filetype)
  if #list == 0 then
    return {}
  end
  return { ignore_symbols = list }
end

return M
