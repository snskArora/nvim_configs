# Keybindings

Leader is `<Space>`. Mode is normal (`n`) unless noted. Source file in brackets.

## General [key_remap.lua]

| Key | Action |
| --- | --- |
| `<leader>nh` | Clear search highlights |
| `<leader>ex` | Open netrw (`:Ex`). **Note:** netrw is disabled for nvim-tree (`loaded_netrw = 1`), so this does nothing |
| `<leader>fnr` | Replace word under cursor in whole file (pre-filled `:%s`) |
| `J` / `K` (visual) | Move selected lines down / up |
| `<leader>p` (visual) | Paste over selection, keep register (`"_dp`) |
| `<leader>P` (visual) | Paste over selection before cursor, keep register (`"_dP`) |

## Windows / splits [key_remap.lua]

| Key | Action |
| --- | --- |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to window left / down / up / right |

## Tabs [key_remap.lua]

| Key | Action |
| --- | --- |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>tf` | Open current buffer in new tab |

## Quickfix [key_remap.lua]

| Key | Action |
| --- | --- |
| `<leader>qs` / `<leader>qc` | Open / close quickfix list |
| `<leader>qn` / `<leader>qp` | Next / previous quickfix item |

## Workspaces [workspaces.nvim]

| Key | Command | Action |
| --- | --- | --- |
| `<leader>wn` | `:WorkspaceNew` | Save current workspace, start a new empty one (name popup: `<CR>` create, Esc cancel) |
| `<leader>wo` | `:WorkspaceOpen` | Open / switch workspace (preview: last saved + folders) |
| `<leader>wD` | `:WorkspaceDelete [name]` | Delete a workspace (picker → confirm popup; with a name: command-line y/N) |
| — | `:WorkspaceSave` | Save the workspace now |
| `<leader>wa` | `:WorkspaceAddFolder [dir]` | Add a folder (picker, starts at cwd) |
| `<leader>wd` | `:WorkspaceRemoveFolder` | Remove folders (multi-select) |

The cwd always follows the common root of the workspace folders. The statusline shows `name (folder count)`.

## Search [workspaces.nvim + telescope.lua]

Searches cover every workspace folder, or the cwd when the workspace has no folders.

| Key | Command | Action | Source |
| --- | --- | --- | --- |
| `<leader>ff` | — | Find files | workspaces.nvim |
| `<leader>fr` | — | Recent files (inside workspace) | workspaces.nvim |
| `<leader>feus` | — | Live grep | workspaces.nvim |
| `<leader>grep` | — | Grep word under cursor | workspaces.nvim |
| `<leader>fs` | `:WorkspaceGrep` | Supercharged grep (`pattern \|:\| glob, glob`), all folders | workspaces.nvim |
| `<leader>fns` | `:WorkspaceGrepSelective` | Supercharged grep in folders you pick | workspaces.nvim |
| `<leader>fcg` | — | Supercharged grep, cwd only | workspaces.nvim |
| `<leader>LB` | — | Open buffers | telescope.lua |

## LSP symbols [telescope.lua]

These use the per-filetype symbol filter in `lua/sunny/lsp_symbols.lua`.

| Key | Action | Source |
| --- | --- | --- |
| `<leader>rf` | Symbols in current buffer | telescope.lua |
| `<leader>arf` | Workspace symbols (servers of current buffer) | telescope.lua |
| `<leader>frf` | Pick a workspace folder → live symbol search inside it (all running servers) | telescope.lua → sunny/folder_symbols.lua |

## LSP (buffer-local, when a server attaches) [lsp.lua]

| Key | Action |
| --- | --- |
| `gd` | Definitions (Telescope) |
| `gD` | Declaration |
| `gR` | References (Telescope) |
| `gi` | Implementations (Telescope) |
| `gt` | Type definitions (Telescope). Overrides Vim's "next tab" in LSP buffers |
| `K` | Hover docs |
| `<leader>ca` (n, v) | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Line diagnostics (float) |
| `<leader>D` | Buffer diagnostics (Telescope) |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

## Git [workspaces.nvim + gitsigns.lua]

| Key | Action | Source |
| --- | --- | --- |
| `<leader>gt` | Neogit: current file's repo, otherwise repo picker | workspaces.nvim |
| `<leader>gs` | Changed files across all workspace repos (diff preview) | workspaces.nvim |
| `<leader>gwt` | Git worktrees (in a workspace: `<CR>` adds as folder) | workspaces.nvim |
| `<leader>gwa` | Create worktree (in a workspace: added as folder, no cd) | workspaces.nvim |
| `<leader>ghn` / `<leader>ghp` | Next / previous hunk (with preview) | gitsigns.lua |
| `<leader>ghs` | Stage hunk | gitsigns.lua |
| `<leader>ghu` | Reset (undo) hunk | gitsigns.lua |
| `<leader>ghi` | Preview hunk inline | gitsigns.lua |

## Harpoon [harpoon.lua] (one list per workspace)

| Key | Action |
| --- | --- |
| `<leader>a` | Add buffer |
| `<leader>A` | Prepend buffer |
| `<leader>l` | Toggle Harpoon menu |
| `<A-1>` … `<A-9>`, `<A-0>` | Jump to item 1 … 9, 10 |
| `<leader><A-1>` … `<leader><A-0>` | Replace item 1 … 10 with current buffer |
| `<C-p>` / `<C-n>` | Previous / next Harpoon item (the descriptions in harpoon.lua are swapped) |

## File tree [file-tree.lua]

| Key | Action |
| --- | --- |
| `<leader>ee` | Toggle tree |
| `<leader>ef` | Reveal current file in tree |
| `<leader>ec` | Collapse tree |
| `<leader>er` | Refresh tree |

Inside the tree, nvim-tree's default keys apply (`g?` lists them).

## Trouble [trouble.lua]

| Key | Action |
| --- | --- |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |

## Treesitter [treesitter.lua]

| Key | Action |
| --- | --- |
| `<C-Space>` | Start / grow selection by node |
| `<BS>` (visual) | Shrink selection |

## Plugin defaults in use

| Key | Action | Plugin |
| --- | --- | --- |
| `ys{motion}{char}` / `ds{char}` / `cs{old}{new}` | Add / delete / change surroundings | nvim-surround |
| `gcc` / `gc{motion}` | Toggle comment | built-in (Neovim 0.10+); Comment.nvim is listed but never set up |

## Inside workspaces.nvim pickers

Each picker shows its keys in the results title.

| Picker | Keys |
| --- | --- |
| Open/switch (`<leader>wo`) | `<CR>` open · `<C-d>` delete highlighted (confirm popup, picker reopens) |
| Delete (`<leader>wD`) | `<CR>` → confirm popup |
| Confirm popup | `No, keep it` highlighted · `<CR>` choose · Esc keep |
| New workspace name popup | type name · `<CR>` create (existing name warns, stays open) · Esc / `<C-c>` cancel |
| Add folder, normal mode | `<CR>` add · `<C-y>` add typed path · `<C-o>` browse mode |
| Add folder, browse mode | `<Tab>` move in/out (`../`, `../../`) · `<CR>` add (on `../` moves up) · `<C-y>` typed path · `<C-o>` normal mode |
| Remove folders (`<leader>wd`) | `<Tab>`/`<CR>` mark · `<C-s>` remove marked · `Esc` cancel |
| Folders to grep (`<leader>fns`) | `<Tab>` mark · `<CR>` grep · `<C-e>` show/hide excluded dirs |
| Repo picker | `<CR>` select (`work/app/ (branch, N changed)`) |
| Changed files (`<leader>gs`) | `<CR>` open file |
| Worktree list (`<leader>gwt`) | `<CR>` switch / add as folder · `<C-d>` delete · `<C-f>` force next delete |
| Folder symbols (`<leader>frf`) | type to search · `<CR>` open |
