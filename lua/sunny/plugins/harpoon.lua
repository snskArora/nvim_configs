return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function ()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add buffer to harpoon" })
    vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "pre-append buffer to harpoon" })
    vim.keymap.set("n", "<leader>l", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "List buffers in harpoon" })

    vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
    vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
    vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
    vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
    vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)
    vim.keymap.set("n", "<A-0>", function() harpoon:list():select(10) end)

    vim.keymap.set("n", "<leader><A-2>", function() harpoon:list():replace_at(2) end)
    vim.keymap.set("n", "<leader><A-3>", function() harpoon:list():replace_at(3) end)
    vim.keymap.set("n", "<leader><A-4>", function() harpoon:list():replace_at(4) end)
    
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Move to next harpooned buffer" })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "move to prev harpooned buffer" })
  end,
}
