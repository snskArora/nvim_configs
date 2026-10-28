# nvim_configs

## To install
- Linux
```git clone https://github.com/sunny-1651/nvim_configs ~/.config/nvim```
- Windows
```git clone https://github.com/sunny-1651/nvim_configs "$env:LOCALAPPDATA\nvim```

A Glimpse of the Final Result
![image](https://github.com/user-attachments/assets/a73e9391-8ae8-4c5b-b01e-305c708f97fd)


### To Remember
Also install the following, these are essential dependencies
+ wget
+ curl
+ gzip
+ tar
+ zip/unzip
+ python
+ cargo
+ git
+ node,npm
+ GO
+ gcc/clang
+ ripgrep [ghub link](https://github.com/BurntSushi/ripgrep)
+ fd [not an essential lib but enables extended capabilities](https://github.com/sharkdp/fd)

For Ubuntu/Debian based distros
```sudo apt update && sudo apt install wget curl gzip tar zip unzip nodejs npm cargo -y```

I use WSL on Windows system so all the dependencies listed are w.r.t. Linux. If Neovim is used on Windows then the first 5 might change, please refer to the package docs for the equivalencies.

Copy the [pycodestyle](./pycodestyle) file to `XDG_CONFIG_HOME/pycodestyle` which usually translates to `~/.config/pycodestyle` in linux

## workspaces.nvim integration (this config)

workspaces.nvim is loaded from
`~/github/workspaces.nvim` (`lua/sunny/plugins/workspaces.lua`). Keys are listed
in [KEYBINDINGS.md](./KEYBINDINGS.md). These pieces live in this config, not
in the plugin:

### Statusline pill (`lua/sunny/plugins/bottombar.lua`)

The first item of `lualine_b` shows `"<workspace> (<folder count>)"` from
`require("workspaces").statusline()`. It's a fixed yellow block (`#FFDA7B` on
`#112638`, bold) that doesn't change with the mode. It ends with the same arrow
as the mode pill (`separator = { right = "\u{E0B0}" }`) and is hidden when no
workspace is active.

```lua
{
  function()
    local ok, ws = pcall(require, "workspaces")
    return ok and ws.statusline() or ""
  end,
  color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
  separator = { right = "\u{E0B0}" }, -- powerline arrow; type it with a Nerd Font
},
```

### Per-filetype LSP symbol filter (`lua/sunny/lsp_symbols.lua`)

Some servers report every table field, array item or literal as a symbol
(lua_ls especially). `lsp_symbols.lua` maps each filetype to the symbol kinds
hidden in `<leader>rf`, `<leader>arf` and `<leader>frf`:

| Filetypes | Hidden kinds |
| --- | --- |
| lua | field, array, object, number, string, boolean, key, null, enummember |
| json, jsonc, yaml, toml, xml, sh, bash, zsh, dockerfile, make, cmake, ps1, markdown | nothing |
| c, cpp, java, go, rust, python, js/ts and other languages | number, string, boolean, null, key |
| terraform, terraform-vars, hcl | attributes (string, number, boolean, null, key, constant, struct, array, object): only blocks stay |
| anything else | the lua list without `field` |

- `ignore_for(ft)` returns the list for a filetype.
- `opts(bufnr)` returns Telescope opts for the buffer.
- `telescope.lua` maps `<leader>rf` / `<leader>arf` to `lsp_document_symbols(lsp_symbols.opts())` / `lsp_workspace_symbols(...)`.

### Folder symbols (`lua/sunny/folder_symbols.lua`, `<leader>frf`)

Pick a top-level workspace folder (`require("workspaces").get_folders()`),
then type to search LSP workspace symbols live across every running server that
supports them, limited to files in that folder. Results are de-duplicated and
filtered with `lsp_symbols.ignore_for()` per result file.
