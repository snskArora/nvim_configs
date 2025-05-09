vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "open explorer" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { silent = true })
keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { silent = true })
keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { silent = true })
keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { silent = true })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Move lines up-down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste over visual selection without sending the overwritten to the default register
keymap.set("x", "<leader>p", "\"_dp", {desc = "Overwrite selection before cursor"}) -- paste after the cursor
keymap.set("x", "<leader>P", "\"_dP", {desc = "Overwrite selection after cursor"}) -- paste before the cursor

-- Replace the current word prompt
keymap.set("n", "<leader>fnr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Navigating quickfis list
keymap.set("n", "<leader>qn", "<CMD>cnext<CR>", {desc = "next item from quickfix list"})
keymap.set("n", "<leader>qp", "<CMD>cprev<CR>", {desc = "previous item from quickfix list"})
keymap.set("n", "<leader>qs", "<CMD>copen<CR>", {desc = "show quickfix list"})
keymap.set("n", "<leader>qc", "<CMD>cclose<CR>", {desc = "close quickfix list"})
